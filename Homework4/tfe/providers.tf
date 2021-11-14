terraform {
  required_providers {
    tfe = {
      version = "~> 0.26.0"
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
