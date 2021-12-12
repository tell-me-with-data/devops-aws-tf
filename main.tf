provider "aws" {
  region = "sa-east-1"
}

resource "aws_subnet" "first_subnet" {
  vpc_id     = aws_vpc.first_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "Prod_SubNet"
  }
}

resource "aws_vpc" "first_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Prod_VPC"
  }
}

# resource "aws_instance" "my_first_server" {
#   ami           = "ami-0a729bdc1acf7528b"
#   instance_type = "t2.micro"
#   tags = {
#     # Name = "ubuntu_16.04"
#   }
# }
