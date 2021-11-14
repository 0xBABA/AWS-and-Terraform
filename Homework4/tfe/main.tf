data "tfe_organization" "tfe_org" {
  name = var.tfc_organization_name
}
resource "tfe_workspace" "workspaces" {
  for_each            = var.workspaces
  name                = each.key
  organization        = data.tfe_organization.tfe_org.name
  auto_apply          = each.value.auto_apply
  global_remote_state = each.value.global_remote_state
  allow_destroy_plan  = each.value.allow_destroy_plan
  trigger_prefixes    = each.value.trigger_prefixes
  working_directory   = each.value.working_directory
  execution_mode      = each.value.execution_mode
  tag_names           = concat(var.tvc_workspace_global_tags, each.value.tags)
  vcs_repo {
    identifier     = var.vcs_repo_identifier
    branch         = var.vcs_repo_branch
    oauth_token_id = var.github_token_id
  }
}
