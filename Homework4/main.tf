resource "tfe_organization" "tfe-org" {
  name  = "yoad-tfe-org"
  email = var.email
}

resource "tfe_workspace" "opsschool-tfe" {
  name         = "tfe-configuration"
  organization = tfe_organization.tfe-org.name
  tag_names    = ["opsschool", "tfe"]
}

resource "tfe_workspace" "opsschool-app" {
  name         = "dev-app"
  organization = tfe_organization.tfe-org.name
  tag_names    = ["opsschool", "app"]
}

resource "tfe_workspace" "opsschool-db" {
  name         = "dev-db"
  organization = tfe_organization.tfe-org.name
  tag_names    = ["opsschool", "db"]
}

resource "tfe_workspace" "opsschool-network" {
  name         = "dev-network"
  organization = tfe_organization.tfe-org.name
  tag_names    = ["opsschool", "network"]
}

