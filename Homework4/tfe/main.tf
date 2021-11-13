resource "tfe_organization" "tfe-org" {
  name  = "yoad-tfe-org"
  email = var.email
}

resource "tfe_workspace" "opsschool-tfe" {
  name                = "tfe-configuration"
  organization        = tfe_organization.tfe-org.name
  global_remote_state = true
  auto_apply          = true
  working_directory   = "/Homework4/tfe"
  tag_names           = ["opsschool", "workspaces"]
}

resource "tfe_workspace" "opsschool-app" {
  name                = "dev-app"
  organization        = tfe_organization.tfe-org.name
  global_remote_state = true
  tag_names           = ["opsschool", "app"]
}

resource "tfe_workspace" "opsschool-db" {
  name                = "dev-db"
  organization        = tfe_organization.tfe-org.name
  global_remote_state = true
  tag_names           = ["opsschool", "db"]
}

resource "tfe_workspace" "opsschool-network" {
  name                = "dev-network"
  organization        = tfe_organization.tfe-org.name
  global_remote_state = true
  working_directory   = "/Homework3/vpc/"
  tag_names           = ["opsschool", "network"]
}


