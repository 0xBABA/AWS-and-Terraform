data "tfe_organization" "tfe_org" {
  name = var.tfc_organization_name
}

#TODO: The workspace with env vars creation should be exported to a module. 
# the module should also accept aws secrets from another module (probably)
# that will create an iam user with programmatic access and output the secrets for the created user. 
# the user module should accept a relevant json policy for the required permissions.  

## create workspaces
resource "tfe_workspace" "workspaces" {
  for_each            = var.workspaces
  name                = each.key
  organization        = var.tfc_organization_name
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

## create env vars
#TODO: this should be a part of the workspace module
resource "tfe_variable" "region_env_var" {
  key          = "AWS_DEFAULT_REGION"
  value        = "us-east-1"
  description  = "aws default region"
  category     = "env"
  sensitive    = false
  workspace_id = tfe_workspace.workspaces["network"].id
}
resource "tfe_variable" "aws_secret_key_env_var" {
  key          = "AWS_SECRET_ACCESS_KEY "
  value        = var.network_aws_secret_access_key
  description  = "aws secret key"
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.workspaces["network"].id
}
resource "tfe_variable" "aws_key_env_var" {
  key          = "AWS_ACCESS_KEY_ID"
  value        = var.network_aws_access_key
  description  = "aws access key"
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.workspaces["network"].id
}


## create registry for vpc module
resource "tfe_registry_module" "vpc-registry-module" {
  vcs_repo {
    display_identifier = var.vpc_module_repo_identifier
    identifier         = var.vpc_module_repo_identifier
    oauth_token_id     = var.github_token_id
  }
}
