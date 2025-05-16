resource "tfe_workspace" "tfc" {
  name               = "tfc"
  execution_mode     = "local"
  terraform_version  = "1.12.0"
  organization       = data.tfe_organization.server.name
  queue_all_runs     = false
  allow_destroy_plan = false

  lifecycle {
    prevent_destroy = true
  }
}

resource "tfe_workspace" "oracle" {
  name                  = "oracle"
  execution_mode        = "remote"
  terraform_version     = "1.12.0"
  organization          = data.tfe_organization.server.name
  queue_all_runs        = false
  speculative_enabled   = false
  file_triggers_enabled = false

  lifecycle {
    prevent_destroy = true
  }
}
