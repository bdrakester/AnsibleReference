provider "aws" {
  profile = "my_aws"
  region = var.aws_region
}

resource "aws_vpc" "AnsibleRef-VPC" {
  cidr_block = "10.80.0.0/16"

  tags = {
    Name = "AnsibleRef-VPC"
  }
}

resource "aws_internet_gateway" "AnsibleRef-IGW" {
  vpc_id = aws_vpc.AnsibleRef-VPC.id

  tags = {
    Name = "AnsibleRef-IGW"
  }
}

resource "aws_subnet" "AnsibleRef-Subnet" {
  cidr_block = "10.80.8.0/24"
  vpc_id = aws_vpc.AnsibleRef-VPC.id
  availability_zone = "us-west-1a"

  tags = {
    Name = "AnsibleRef-Subnet"
  }
}

resource "aws_route_table" "AnsibleRef-RT" {
  vpc_id = aws_vpc.AnsibleRef-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.AnsibleRef-IGW.id
  }

  tags = {
    Name = "AnsibleRef-RT"
  }
}

resource "aws_route_table_association" "AnsibleRef-RTA" {
  route_table_id = aws_route_table.AnsibleRef-RT.id
  subnet_id = aws_subnet.AnsibleRef-Subnet.id
}





