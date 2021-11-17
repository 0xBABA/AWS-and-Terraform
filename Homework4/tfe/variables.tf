variable "email" {
  default = "yoadlanger@gmail.com"
  type    = string
}

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
  default = "hw4"
  type    = string
}

variable "vpc_module_repo_identifier" {
  default = "0xBABA/terraform-aws-vpc"
}

variable "tfc_organization_name" {
  default = "yoad-tfc-org"
  type    = string
}

variable "tvc_workspace_global_tags" {
  default = ["opsschool"]
  type    = list(any)
}

variable "workspaces" {
  type = map(object({
    auto_apply          = bool
    global_remote_state = bool
    allow_destroy_plan  = bool
    trigger_prefixes    = list(string)
    working_directory   = string
    execution_mode      = string
    tags                = list(string)
  }))
}
variable "network_aws_access_key" {
  type = string
}

variable "network_aws_secret_access_key" {
  type = string
}

variable "aws_vpc_allaccess_policy" {
  type    = string
  default = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}
