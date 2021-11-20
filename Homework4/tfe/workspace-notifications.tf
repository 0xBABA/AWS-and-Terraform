resource "tfe_notification_configuration" "network_slack" {
  name             = "network-notification"
  enabled          = true
  destination_type = "slack"
  triggers         = ["run:completed"]
  url              = var.slack_notification_url
  workspace_id     = tfe_workspace.network.id
}

resource "tfe_notification_configuration" "servers_slack" {
  name             = "network-notification"
  enabled          = true
  destination_type = "slack"
  triggers         = ["run:completed"]
  url              = var.slack_notification_url
  workspace_id     = tfe_workspace.servers.id
}

resource "tfe_notification_configuration" "dbs_slack" {
  name             = "network-notification"
  enabled          = true
  destination_type = "slack"
  triggers         = ["run:completed"]
  url              = var.slack_notification_url
  workspace_id     = tfe_workspace.dbs.id
}
