module "github-env" {
  source   = "../module/github-environments"
  repo     = "maccas-api"
  branches = ["main", "v2.x"]
  environments = [
    { name = "production" },
  ]
}

resource "github_actions_secret" "coolify-token" {
  repository      = "maccas-api"
  secret_name     = "COOLIFY_TOKEN"
  plaintext_value = module.coolify-api-readonly-secret.secret_value
}

resource "github_actions_secret" "coolify-webhook" {
  repository      = "maccas-api"
  secret_name     = "COOLIFY_WEBHOOK"
  plaintext_value = module.coolify-api-webhook.secret_value
}

resource "github_actions_secret" "tailscale-client-id" {
  repository      = "maccas-api"
  secret_name     = "TS_OAUTH_CLIENT_ID"
  plaintext_value = module.tailscale-client-id.secret_value
}

resource "github_actions_secret" "tailscale-client-secret" {
  repository      = "maccas-api"
  secret_name     = "TS_OAUTH_SECRET"
  plaintext_value = module.tailscale-client-secret.secret_value
}
