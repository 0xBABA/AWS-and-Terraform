terraform {
  required_providers {
    tfe = {
      version = "~> 0.26.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.65.0"
    }
  }

  # backend "remote" {
  #   hostname     = "app.terraform.io"
  #   organization = "yoad-tfc-org"
  #   workspaces {
  #     name = "tfe-configuration"
  #   }
  # }
}

provider "tfe" {
  token = var.tfe_token
}

provider "aws" {
  region = "us-east-1"
}
