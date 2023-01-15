resource "aws_secretsmanager_secret" "api-secret-apim-api-key" {
  name = "MaccasApi-ApimApiKey"
}

resource "aws_secretsmanager_secret_version" "api-secret-apim-api-key" {
  secret_id     = aws_secretsmanager_secret.api-secret-apim-api-key.id
  secret_string = azurerm_api_management_subscription.maccas-policy-apim-subscription.primary_key
}

resource "aws_secretsmanager_secret" "api-secret-jwt-bypass" {
  name = "MaccasApi-JwtBypassKey"
}

resource "aws_secretsmanager_secret_version" "api-secret-jwt-bypass" {
  secret_id     = aws_secretsmanager_secret.api-secret-jwt-bypass.id
  secret_string = base64encode(random_password.jwt-bypass-token.result)
}

resource "aws_secretsmanager_secret" "api-secret-application-audience" {
  name = "MaccasApi-ApplicationAudience"
}

resource "aws_secretsmanager_secret_version" "api-secret-application-audience" {
  secret_id     = aws_secretsmanager_secret.api-secret-application-audience.id
  secret_string = azuread_application.this.application_id
}
