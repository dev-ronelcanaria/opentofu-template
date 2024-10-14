resource "aws_vpc" "app_vpc" {
  cidr_block = var.vpc_name
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "app_subnet_1" {
  vpc_id = aws_vpc.app_vpc.id
  cidr_block = var.vpc_subnet_1_cidr_block
  availability_zone = var.vpc_subnet_1_availability_zone
  tags = {
    Name = var.vpc_subnet_1_name
  }
}

resource "aws_subnet" "app_subnet_2" {
  vpc_id = aws_vpc.app_vpc.id
  cidr_block = var.vpc_subnet_2_cidr_block
  availability_zone = var.vpc_subnet_2_availability_zone
  tags = {
    Name = var.vpc_subnet_2_name
  }
}

resource "aws_internet_gateway" "app_igw" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name = var.vpc_igw
  }
}

resource "aws_route_table" "app_rtb" {
  vpc_id = aws_vpc.app_vpc.id
  route {
    cidr_block = var.vpc_rtb_cidr_block
    gateway_id = aws_internet_gateway.app_igw.id
  }
}

resource "aws_route_table_association" "app_rtb_assoc" {
  subnet_id = aws_subnet.app_subnet_1.id
  route_table_id = aws_route_table.app_rtb.id
}