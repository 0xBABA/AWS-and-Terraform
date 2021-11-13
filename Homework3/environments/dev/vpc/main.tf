data "aws_availability_zones" "available" {
  filter {
    name   = "state"
    values = ["available"]
  }
}

module "vpc" {
  source               = "app.terraform.io/yoad-terrafom-cloud/vpc/aws"
  version              = "0.0.1"
  global_name_prefix   = "hw4"
  azs                  = data.aws_availability_zones.available.names
  vpc_cidr_block       = var.vpc_cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}
