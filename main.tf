provider "aws" {
  region = "sa-east-1"
}

variable "v_ami_id" {
  default = "ami-09ed4bb0f78259804"
  description = "AMI ID of ubuntu-docker-18-demo"
}

variable "v_instance_type" {
  default = "t2.micro"
  description = "Instace Type of aws instance"
}

resource "aws_instance" "tell_me_1_dev" {
  ami           = var.v_ami_id
  instance_type = var.v_instance_type
  tags = {
    Name       = "Tell_Me_1_Dev"
    Enviroment = "Dev"
  }
}


# # Step 1

# resource "aws_vpc" "proj_vpc" {
#   cidr_block = "10.0.0.0/16"
#   tags = {
#     Name = "Proj_Vpc"
#   }
# }

# # Step 2

# resource "aws_internet_gateway" "proj_internet_gateway" {
#   vpc_id = aws_vpc.proj_vpc.id
#   tags = {
#     Name = "Proj_Internet_Gateway"
#   }
# }

# # Step 3

# resource "aws_route_table" "proj_route_table" {
#   vpc_id = aws_vpc.proj_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.proj_internet_gateway.id
#   }

#   route {
#     ipv6_cidr_block = "::/0"
#     gateway_id      = aws_internet_gateway.proj_internet_gateway.id
#   }

#   tags = {
#     Name = "Proj_Route_Table"
#   }

# }

# # Step 4

# resource "aws_subnet" "proj_subnet" {
#   vpc_id     = aws_vpc.proj_vpc.id
#   cidr_block = "10.0.1.0/24"
#   tags = {
#     Name = "Proj_Subnet"
#   }
# }

# # Step 5

# resource "aws_route_table_association" "proj_route_table_association" {
#   subnet_id      = aws_subnet.proj_subnet.id
#   route_table_id = aws_route_table.proj_route_table.id
# }

# # Step 6

# resource "aws_security_group" "proj_security_group" {
#   name        = "allow_web_traffic"
#   description = "Allow TLS inbound traffic"
#   vpc_id      = aws_vpc.proj_vpc.id

#   ingress {
#     description = "HTTPS from VPC"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "TCP"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "HTTP from VPC"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "TCP"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "SSH from VPC"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "TCP"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "Proj_Security_Group"
#   }

# }

# # Step 7

# resource "aws_network_interface" "proj_network_interface" {
#   subnet_id       = aws_subnet.proj_subnet.id
#   private_ips     = ["10.0.1.50"]
#   security_groups = [aws_security_group.proj_security_group.id]
# }

# # Step 8

# resource "aws_eip" "proj_eip" {
#   vpc                       = true
#   network_interface         = aws_network_interface.proj_network_interface.id
#   associate_with_private_ip = "10.0.1.50"
#   depends_on = [
#     aws_internet_gateway.proj_internet_gateway
#   ]
# }

# # Step 9

# resource "aws_instance" "proj_instance" {
#   ami               = "ami-0a729bdc1acf7528b"
#   instance_type     = "t2.micro"
#   key_name          = "slayer-dev-machine"
#   network_interface {
#     device_index         = 0
#     network_interface_id = aws_network_interface.proj_network_interface.id
#   }

#   user_data = <<-EOF
#               #!/bin/bash
#               sudo apt update -y
#               sudo apt install apache2 -y
#               sudo systemctl start apache2
#               sudo bash -c 'echo your very first Proj Web Server > /var/www/html/index.html'
#               EOF

#   tags = {
#     Name = "Proj_Instance"
#   }
# }

# resource "aws_subnet" "first_subnet" {
#   vpc_id     = aws_vpc.first_vpc.id
#   cidr_block = "10.0.1.0/24"
#   tags = {
#     Name = "Prod_SubNet"
#   }
# }

# resource "aws_vpc" "first_vpc" {
#   cidr_block = "10.0.0.0/16"
#   tags = {
#     Name = "Prod_VPC"
#   }
# }

# resource "aws_instance" "my_first_server" {
#   ami           = "ami-0a729bdc1acf7528b"
#   instance_type = "t2.micro"
#   tags = {
#     # Name = "ubuntu_16.04"
#   }
# }
