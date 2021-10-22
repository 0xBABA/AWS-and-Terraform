##################################################################################
# RESOURCES
##################################################################################

## creating the vpc
resource "aws_vpc" "hw2_main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "hw2_main_vpc"
  }
}

## creating IGW
resource "aws_internet_gateway" "hw2_main_igw" {
  vpc_id = aws_vpc.hw2_main_vpc.id

  tags = {
    Name = "hw2_main_igw"
  }
}

## creating the 2 public subnets
resource "aws_subnet" "hw2_pub_sn" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.hw2_main_vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "hw2_pub_sn-${count.index}"
  }
}

## creating route tabkle for public subnets
resource "aws_route_table" "hw2_pub_rt" {
  vpc_id = aws_vpc.hw2_main_vpc.id

  tags = {
    Name = "hw2_pub_rt"
  }
}

resource "aws_route" "hw2_pub_route" {
  route_table_id         = aws_route_table.hw2_pub_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.hw2_main_igw.id
}

## associating the route table with the public subnets
resource "aws_route_table_association" "hw2_pub_rt_a" {
  count          = 2
  subnet_id      = aws_subnet.hw2_pub_sn.*.id[count.index]
  route_table_id = aws_route_table.hw2_pub_rt.id
}


## creating the 2 private subnets
resource "aws_subnet" "hw2_private_sn" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.hw2_main_vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "hw2_private_sn"
  }
}

## creating EIP for NAT GW
resource "aws_eip" "hw2_nat_eip" {
  vpc = true
}

## creating NAT GW for private subnets
resource "aws_nat_gateway" "hw2_nat_gw" {
  allocation_id = aws_eip.hw2_nat_eip.id
  subnet_id     = aws_subnet.hw2_pub_sn.*.id[0]

  tags = {
    Name = "hw2_nat_gw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.hw2_main_igw]
}

## route table for private subnets
resource "aws_route_table" "hw2_private_rt" {
  vpc_id = aws_vpc.hw2_main_vpc.id

  tags = {
    Name = "hw2_private_rt"
  }
}

resource "aws_route" "hw2_private_route" {
  route_table_id         = aws_route_table.hw2_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.hw2_nat_gw.id
}

## associating the route table with the private subnets
resource "aws_route_table_association" "hw2_private_rt_a" {
  count          = 2
  subnet_id      = aws_subnet.hw2_private_sn.*.id[count.index]
  route_table_id = aws_route_table.hw2_private_rt.id
}
