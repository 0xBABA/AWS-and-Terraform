output "organization_info" {
  value = data.tfe_organization.tfe_org
}

output "workspaces_info" {
  value = tfe_workspace.workspaces
}

