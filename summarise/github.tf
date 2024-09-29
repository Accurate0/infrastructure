resource "github_actions_secret" "coolify-token" {
  repository      = "summarise"
  secret_name     = "COOLIFY_TOKEN"
  plaintext_value = module.coolify-api-readonly-secret.secret_value
}

resource "github_actions_secret" "coolify-webhook" {
  repository      = "summarise"
  secret_name     = "COOLIFY_WEBHOOK"
  plaintext_value = module.coolify-api-webhook.secret_value
}

