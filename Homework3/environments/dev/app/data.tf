data "aws_ami" "ubuntu-18" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

data "aws_vpc" "get_vpc_info" {
  filter {
    name   = "tag:Name"
    values = [format("%s-${var.vpc_name}", var.global_name_prefix)]
  }
}

# TODO: consult with Gai. what is the best way to get the subnet IDs for this?
# https://stackoverflow.com/questions/64094992/referencing-terraform-resource-created-in-a-different-folder
# data "aws_subnet" "get_subnet_info" {
#   filter {
#     name   = "tag:Name"
#     values = [format("%s-%s-*", var.global_name_prefix, var.public_subnet_prefix)]
#   }
# }
# data "tf_vpc_state" "public_subnets" {
#   backend = "local"
#   config = {
#     path = "../vpc/terraform.tfstate"
#   }
# }
data "aws_subnet" "get_subnet_info_0" {
  filter {
    name   = "tag:Name"
    values = [format("%s-%s-0", var.global_name_prefix, var.public_subnet_prefix)]
  }
}
data "aws_subnet" "get_subnet_info_1" {
  filter {
    name   = "tag:Name"
    values = [format("%s-%s-1", var.global_name_prefix, var.public_subnet_prefix)]
  }
}
