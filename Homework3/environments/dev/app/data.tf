data "aws_ami" "ubuntu-18" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = var.tfc_org
    workspaces = {
      name = "network"
    }
  }
}

#data "aws_vpc" "get_vpc_info" {
#  filter {
#    name   = "tag:Name"
#    values = [format("%s-${var.vpc_name}", var.global_name_prefix)]
#  }
#}
#
## TODO: consult with Gai. what is the best way to get the subnet IDs for this?
## https://stackoverflow.com/questions/64094992/referencing-terraform-resource-created-in-a-different-folder
#data "aws_subnets" "get_subnets_info" {
#  filter {
#    name   = "tag:Name"
#    values = [format("%s-%s-*", var.global_name_prefix, var.public_subnet_prefix)]
#  }
#}
