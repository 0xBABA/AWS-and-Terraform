data "aws_availability_zones" "available" {
  filter {
    name   = "state"
    values = ["available"]
  }
}

module "vpc" {
  source               = "../../../modules/vpc"
  global_name_prefix   = "hw3"
  azs                  = data.aws_availability_zones.available.names
  vpc_cidr_block       = var.vpc_cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}
