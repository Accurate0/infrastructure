resource "github_actions_secret" "api-key-secret" {
  repository      = "maccas-api"
  secret_name     = "API_CONFIG_API_KEY"
  plaintext_value = azurerm_api_management_subscription.maccas-policy-apim-subscription.primary_key
}

resource "github_actions_secret" "jwt-bypass-secret" {
  repository      = "maccas-api"
  secret_name     = "API_CONFIG_JWT_BYPASS_KEY"
  plaintext_value = random_password.jwt-bypass-token.result
}
