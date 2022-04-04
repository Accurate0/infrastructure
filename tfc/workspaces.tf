resource "tfe_workspace" "apim" {
  name           = "apim"
  execution_mode = "local"
  organization   = tfe_organization.server.name
  queue_all_runs = false
}

resource "tfe_workspace" "cloudflare" {
  name           = "cloudflare"
  execution_mode = "local"
  organization   = tfe_organization.server.name
  queue_all_runs = false
}

resource "tfe_workspace" "light-api" {
  name           = "light-api"
  execution_mode = "local"
  organization   = tfe_organization.server.name
  queue_all_runs = false
}

resource "tfe_workspace" "oracle" {
  name                  = "oracle"
  execution_mode        = "remote"
  terraform_version     = "1.1.2"
  organization          = tfe_organization.server.name
  queue_all_runs        = false
  speculative_enabled   = false
  file_triggers_enabled = false
}

resource "tfe_workspace" "weather-api" {
  name           = "weather-api"
  execution_mode = "local"
  organization   = tfe_organization.server.name
  queue_all_runs = false
}

resource "tfe_workspace" "ww3-api" {
  name           = "ww3-api"
  execution_mode = "local"
  organization   = tfe_organization.server.name
  queue_all_runs = false
}
