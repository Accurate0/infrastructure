resource "aws_vpc" "internal-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "internal-vpc"
  }
}

resource "aws_subnet" "internal-subnet-syda" {
  vpc_id                  = aws_vpc.internal-vpc.id
  availability_zone       = "ap-southeast-2a"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "internal-subnet-syda"
  }
}

resource "aws_internet_gateway" "internal-gw" {
  vpc_id = aws_vpc.internal-vpc.id

  tags = {
    Name = "internal-gw"
  }
}

resource "aws_route_table" "internal-default-routes" {
  vpc_id = aws_vpc.internal-vpc.id

  tags = {
    Name = "internal-default-routes"
  }
}

resource "aws_route" "internet-route" {
  route_table_id         = aws_route_table.internal-default-routes.id
  gateway_id             = aws_internet_gateway.internal-gw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "internal-syda-routes" {
  subnet_id      = aws_subnet.internal-subnet-syda.id
  route_table_id = aws_route_table.internal-default-routes.id
}

resource "aws_main_route_table_association" "default" {
  vpc_id         = aws_vpc.internal-vpc.id
  route_table_id = aws_route_table.internal-default-routes.id
}
