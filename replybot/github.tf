resource "github_actions_secret" "api-key-secret" {
  repository      = "replybot"
  secret_name     = "API_KEY"
  plaintext_value = azurerm_api_management_subscription.internal-policy-apim-subscription.primary_key
}
