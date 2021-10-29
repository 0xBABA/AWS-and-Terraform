data "aws_ami" "ubuntu-18" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

data "aws_subnets" "get_subnets_info" {
  filter {
    name   = "tag:Name"
    values = [format("%s-%s-*", var.global_name_prefix, var.private_subnet_prefix)]
  }
}

data "aws_vpc" "get_vpc_info" {
  filter {
    name   = "tag:Name"
    values = [format("%s-${var.vpc_name}", var.global_name_prefix)]
  }
}
