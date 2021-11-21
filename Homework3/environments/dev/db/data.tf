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

