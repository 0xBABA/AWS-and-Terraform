resource "tfe_run_trigger" "servers-trigger" {
  workspace_id  = tfe_workspace.workspaces["servers"].id
  sourceable_id = tfe_workspace.workspaces["network"].id
}

resource "tfe_run_trigger" "dbs-trigger" {
  workspace_id  = tfe_workspace.workspaces["dbs"].id
  sourceable_id = tfe_workspace.workspaces["network"].id
}
