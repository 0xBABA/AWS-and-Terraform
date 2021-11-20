
variable "tfe_token" {
  type = string
}

variable "github_token_id" {
  type = string
}

variable "vcs_repo_identifier" {
  default = "0xBABA/AWS-and-Terraform"
  type    = string
}

variable "vcs_repo_branch" {
  default = "hw4-cleaner"
  type    = string
}

variable "vpc_module_repo_identifier" {
  default = "0xBABA/terraform-aws-vpc"
}

variable "tfc_organization_name" {
  default = "yoad-tfc-org"
  type    = string
}

variable "tfc_workspace_global_tags" {
  default = ["opsschool"]
  type    = list(any)
}


variable "network_aws_access_key" {
  type = string
}

variable "network_aws_secret_access_key" {
  type = string
}

variable "servers_aws_access_key" {
  type = string
}

variable "servers_aws_secret_access_key" {
  type = string
}


variable "slack_notification_url" {
  type = string
}
