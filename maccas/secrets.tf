resource "aws_secretsmanager_secret" "api-secret-apim-api-key" {
  name = "MaccasApi-ApimApiKey"
}

resource "aws_secretsmanager_secret_version" "api-secret-apim-api-key" {
  secret_id     = aws_secretsmanager_secret.api-secret-apim-api-key.id
  secret_string = azurerm_api_management_subscription.maccas-policy-apim-subscription.primary_key
}

resource "aws_secretsmanager_secret" "api-secret-places-api-key" {
  name = "MaccasApi-PlacesApiKey"
}

resource "aws_secretsmanager_secret_version" "api-secret-places-api-key" {
  secret_id     = aws_secretsmanager_secret.api-secret-places-api-key.id
  secret_string = google_apikeys_key.this.key_string
}
