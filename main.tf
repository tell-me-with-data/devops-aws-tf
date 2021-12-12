terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    random = {
      source = "hashicorp/random"
    }
  }
  cloud {
    organization = "tell-me-with-data"

    workspaces {
      name = "proj-workspace-1"
    }
  }
}

provider "aws" {
  region = "sa-east-1"
}

resource "aws_vpc" "proj_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Proj_Vpc"
  }
}

resource "aws_internet_gateway" "proj_internet_gateway" {
  vpc_id = aws_vpc.proj_vpc.id
  tags = {
    Name = "Proj_Internet_Gateway"
  }
}

resource "aws_route_table" "proj_route_table" {
  vpc_id = aws_vpc.proj_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.proj_internet_gateway.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.proj_internet_gateway.id
  }

  tags = {
    Name = "Proj_Route_Table"
  }

}

resource "aws_subnet" "proj_subnet" {
  vpc_id     = aws_vpc.proj_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "Proj_Subnet"
  }
}

resource "aws_route_table_association" "proj_route_table_association" {
  subnet_id      = aws_subnet.proj_subnet.id
  route_table_id = aws_route_table.proj_route_table.id
}

resource "aws_security_group" "proj_security_group" {
  name        = "allow_web_traffic"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.proj_vpc.id

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Proj_Security_Group"
  }

}

resource "aws_network_interface" "proj_network_interface" {
  subnet_id       = aws_subnet.proj_subnet.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.proj_security_group.id]
}

resource "aws_eip" "proj_eip" {
  vpc                       = true
  network_interface         = aws_network_interface.proj_network_interface.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [
    aws_internet_gateway.proj_internet_gateway
  ]
}

resource "aws_instance" "proj_instance" {
  ami           = "ami-0a729bdc1acf7528b"
  instance_type = "t2.micro"
  key_name      = "slayer-dev-machine"
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.proj_network_interface.id
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install apache2 -y
              sudo systemctl start apache2
              sudo bash -c 'echo your very first Proj Web Server > /var/www/html/index.html'
              EOF

  tags = {
    Name = "Proj_Instance"
  }
}
