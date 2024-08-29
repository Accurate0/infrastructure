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

