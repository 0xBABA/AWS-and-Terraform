resource "tfe_workspace" "dbs" {
  name                      = "dbs"
  organization              = var.tfc_organization_name
  auto_apply                = true
  global_remote_state       = false
  remote_state_consumer_ids = null
  allow_destroy_plan        = true
  working_directory         = "/Homework3/environments/dev/db/"
  execution_mode            = "remote"
  tag_names                 = concat(var.tfc_workspace_global_tags, ["dbs"])
  vcs_repo {
    identifier     = var.vcs_repo_identifier
    branch         = var.vcs_repo_branch
    oauth_token_id = var.github_token_id
  }
}


resource "tfe_variable" "dbs_region_env_var" {
  key          = "AWS_DEFAULT_REGION"
  value        = "us-east-1"
  description  = "aws default region"
  category     = "env"
  sensitive    = false
  workspace_id = tfe_workspace.dbs.id
}
resource "tfe_variable" "dbs_aws_secret_key_env_var" {
  key          = "AWS_SECRET_ACCESS_KEY "
  value        = var.servers_aws_secret_access_key
  description  = "aws secret key"
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.dbs.id
}
resource "tfe_variable" "dbs_aws_key_env_var" {
  key          = "AWS_ACCESS_KEY_ID"
  value        = var.servers_aws_access_key
  description  = "aws access key"
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.dbs.id
}
