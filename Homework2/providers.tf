terraform {
  required_version = "1.0.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.63"
    }
  }
}

##################################################################################
# PROVIDERS
##################################################################################
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      owner   = var.owner_tag
      purpose = "whiskey"
      context = "opsschool_hw2"
    }
  }
}
