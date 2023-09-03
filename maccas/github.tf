resource "github_actions_secret" "vercen-project-id" {
  repository      = "maccas-web"
  secret_name     = "VERCEL_PROJECT_ID"
  plaintext_value = vercel_project.maccas-web.id
}

resource "github_actions_secret" "api-gateway-id" {
  repository      = "maccas-api"
  secret_name     = "AWS_API_GATEWAY_ID"
  plaintext_value = aws_apigatewayv2_api.this.id
}

resource "github_actions_secret" "api-gateway-id-dev" {
  repository      = "maccas-api"
  secret_name     = "AWS_API_GATEWAY_ID_DEV"
  plaintext_value = aws_apigatewayv2_api.this-dev.id
}

resource "github_actions_secret" "integration-id" {
  repository      = "maccas-api"
  secret_name     = "AWS_INTEGRATION_ID"
  plaintext_value = aws_apigatewayv2_integration.this.id
}

resource "github_actions_secret" "integration-id-dev" {
  repository      = "maccas-api"
  secret_name     = "AWS_INTEGRATION_ID_DEV"
  plaintext_value = aws_apigatewayv2_integration.this-dev.id
}

resource "github_actions_secret" "adb2c-application-id" {
  repository      = "maccas-api"
  secret_name     = "ADB2C_APPLICATION_ID"
  plaintext_value = azuread_application.this.application_id
}
