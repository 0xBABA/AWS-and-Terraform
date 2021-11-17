workspaces = {
  network = {
    auto_apply          = true
    global_remote_state = true
    allow_destroy_plan  = true
    trigger_prefixes    = null
    working_directory   = "/Homework3/environments/dev/vpc/"
    execution_mode      = "remote"
    tags                = ["network"]

  }
}

