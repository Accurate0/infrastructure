resource "github_actions_secret" "vercen-project-id" {
  repository      = "maccas-web"
  secret_name     = "VERCEL_PROJECT_ID"
  plaintext_value = vercel_project.maccas-web.id
}

resource "github_actions_environment_secret" "api-gateway-id" {
  environment     = "production-infra"
  repository      = "maccas-api"
  secret_name     = "AWS_API_GATEWAY_ID"
  plaintext_value = aws_apigatewayv2_api.this.id
}

resource "github_actions_environment_secret" "api-gateway-id-dev" {
  environment     = "development-infra"
  repository      = "maccas-api"
  secret_name     = "AWS_API_GATEWAY_ID"
  plaintext_value = aws_apigatewayv2_api.this-dev.id
}

resource "github_actions_environment_secret" "integration-id" {
  environment     = "production-infra"
  repository      = "maccas-api"
  secret_name     = "AWS_INTEGRATION_ID"
  plaintext_value = aws_apigatewayv2_integration.this.id
}

resource "github_actions_environment_secret" "integration-id-dev" {
  environment     = "development-infra"
  repository      = "maccas-api"
  secret_name     = "AWS_INTEGRATION_ID"
  plaintext_value = aws_apigatewayv2_integration.this-dev.id
}

resource "github_actions_environment_secret" "authorizer-id" {
  environment     = "production-infra"
  repository      = "maccas-api"
  secret_name     = "AWS_AUTHORIZER_ID"
  plaintext_value = aws_apigatewayv2_authorizer.this.id
}

resource "github_actions_environment_secret" "authorizer-id-dev" {
  environment     = "development-infra"
  repository      = "maccas-api"
  secret_name     = "AWS_AUTHORIZER_ID"
  plaintext_value = aws_apigatewayv2_authorizer.this-dev.id
}
