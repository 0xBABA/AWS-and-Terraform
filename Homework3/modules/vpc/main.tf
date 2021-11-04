##################################################################################
# Module creates:
# 1 VPC
# 2 private subnets
# 2 public subnets
# 1 IGW
# 2 NAT GWs
# 2 EIPs (for NATs)
# 3 route tables (1 for public SN, 2 for private SNs)
##################################################################################

## creating the vpc
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = format("%s-${var.vpc_name}", var.global_name_prefix)
  }
}

## creating IGW
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = format("%s-main_igw", var.global_name_prefix)
  }
}

## creating the 2 public subnets
resource "aws_subnet" "public_sn" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = format("%s-%s-${count.index}", var.global_name_prefix, var.public_subnet_prefix)
  }
}

## creating route table for public subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = format("%s-${var.public_route_table_name}", var.global_name_prefix)
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_igw.id
}

## associating the route table with the public subnets
resource "aws_route_table_association" "public_rt_a" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public_sn.*.id[count.index]
  route_table_id = aws_route_table.public_rt.id
}


## creating the 2 private subnets
resource "aws_subnet" "private_sn" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = format("%s-%s-${count.index}", var.global_name_prefix, var.private_subnet_prefix)
  }
}

## creating EIP for NAT GW
resource "aws_eip" "nat_eip" {
  count = length(var.private_subnet_cidrs)
  vpc   = true
}

## creating NAT GWs for the private subnets
resource "aws_nat_gateway" "nat_gw" {
  count         = length(var.public_subnet_cidrs)
  allocation_id = aws_eip.nat_eip.*.id[count.index]
  subnet_id     = aws_subnet.public_sn.*.id[count.index]

  tags = {
    Name = format("%s-nat_gw", var.global_name_prefix)
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main_igw]
}

## route table for private subnets
resource "aws_route_table" "private_rt" {
  count  = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = format("%s-${var.private_route_table_name}", var.global_name_prefix)
  }
}

resource "aws_route" "private_route" {
  count                  = length(var.private_subnet_cidrs)
  route_table_id         = aws_route_table.private_rt.*.id[count.index]
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat_gw.*.id[count.index]
}

## associating the route table with the private subnets
resource "aws_route_table_association" "private_rt_a" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private_sn.*.id[count.index]
  route_table_id = aws_route_table.private_rt.*.id[count.index]
}


