resource "tfe_workspace" "tfc" {
  name               = "tfc"
  execution_mode     = "local"
  terraform_version  = "1.1.2"
  organization       = tfe_organization.server.name
  queue_all_runs     = false
  allow_destroy_plan = false
}

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

resource "tfe_workspace" "database" {
  name                      = "database"
  execution_mode            = "local"
  organization              = tfe_organization.server.name
  queue_all_runs            = false
  remote_state_consumer_ids = [tfe_workspace.weather-api.id]
}

resource "tfe_workspace" "sandbox" {
  name           = "sandbox"
  execution_mode = "local"
  organization   = tfe_organization.server.name
  queue_all_runs = false
}

resource "tfe_workspace" "maccas-api" {
  name           = "maccas-api"
  execution_mode = "local"
  organization   = tfe_organization.server.name
  queue_all_runs = false
}

resource "tfe_workspace" "places-api" {
  name           = "places-api"
  execution_mode = "local"
  organization   = tfe_organization.server.name
  queue_all_runs = false
}

resource "tfe_workspace" "kvp-api" {
  name           = "kvp-api"
  execution_mode = "local"
  organization   = tfe_organization.server.name
  queue_all_runs = false
}

resource "tfe_workspace" "log-api" {
  name           = "log-api"
  execution_mode = "local"
  organization   = tfe_organization.server.name
  queue_all_runs = false
}

resource "tfe_workspace" "aws" {
  name           = "aws"
  execution_mode = "local"
  organization   = tfe_organization.server.name
  queue_all_runs = false
}

resource "tfe_workspace" "maccas-api-v2" {
  name           = "maccas-api-v2"
  execution_mode = "local"
  organization   = tfe_organization.server.name
  queue_all_runs = false
}
