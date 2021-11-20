
## create registry for vpc module
resource "tfe_registry_module" "vpc-registry-module" {
  vcs_repo {
    display_identifier = var.vpc_module_repo_identifier
    identifier         = var.vpc_module_repo_identifier
    oauth_token_id     = var.github_token_id
  }
}
