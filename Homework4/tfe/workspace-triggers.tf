resource "tfe_run_trigger" "servers-trigger" {
  workspace_id  = tfe_workspace.servers.id
  sourceable_id = tfe_workspace.network.id
}

resource "tfe_run_trigger" "dbs-trigger" {
  workspace_id  = tfe_workspace.dbs.id
  sourceable_id = tfe_workspace.network.id
}
