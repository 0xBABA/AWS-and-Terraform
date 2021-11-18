workspaces = {
  network = {
    auto_apply          = true
    global_remote_state = true
    # remote_state_consumer_ids = [requires ids of the workspaces to share state with]
    allow_destroy_plan = true
    trigger_prefixes   = null
    working_directory  = "/Homework3/environments/dev/vpc/"
    execution_mode     = "remote"
    tags               = ["network"]
  }
  servers = {
    auto_apply          = true
    global_remote_state = true
    allow_destroy_plan  = true
    trigger_prefixes    = null
    working_directory   = "/Homework3/environments/dev/app/"
    execution_mode      = "remote"
    tags                = ["app", "nginx"]
  }
  dbs = {
    auto_apply          = true
    global_remote_state = true
    allow_destroy_plan  = true
    trigger_prefixes    = null
    working_directory   = "/Homework3/environments/dev/db/"
    execution_mode      = "remote"
    tags                = ["db"]
  }
}

