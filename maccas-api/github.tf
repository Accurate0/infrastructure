resource "github_actions_secret" "api-key-secret" {
  repository      = "maccas-api"
  secret_name     = "API_CONFIG_API_KEY"
  plaintext_value = azurerm_api_management_subscription.maccas-policy-apim-subscription.primary_key
}

resource "github_actions_secret" "jwt-bypass-secret" {
  repository      = "maccas-api"
  secret_name     = "API_CONFIG_JWT_BYPASS_KEY"
  plaintext_value = base64encode(random_password.jwt-bypass-token.result)
}

resource "github_actions_secret" "vercen-project-id" {
  repository      = "maccas-web"
  secret_name     = "VERCEL_PROJECT_ID"
  plaintext_value = vercel_project.maccas-web.id
}
