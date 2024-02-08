resource "github_actions_secret" "vercen-project-id" {
  repository      = "maccas-web"
  secret_name     = "VERCEL_PROJECT_ID"
  plaintext_value = vercel_project.maccas-web-v2.id
}

resource "github_actions_environment_secret" "api-gateway-id" {
  environment     = "production-infra"
  repository      = "maccas-api"
  secret_name     = "AWS_API_GATEWAY_ID"
  plaintext_value = aws_apigatewayv2_api.this.id
}

resource "github_actions_environment_secret" "integration-id" {
  environment     = "production-infra"
  repository      = "maccas-api"
  secret_name     = "AWS_INTEGRATION_ID"
  plaintext_value = aws_apigatewayv2_integration.this.id
}

resource "github_actions_environment_secret" "authorizer-id" {
  environment     = "production-infra"
  repository      = "maccas-api"
  secret_name     = "AWS_AUTHORIZER_ID"
  plaintext_value = aws_apigatewayv2_authorizer.this.id
}


module "github-env" {
  source   = "../module/github-environments"
  repo     = "maccas-api"
  branches = ["main", "v2.x"]
  environments = [
    { name = "production" },
    { name = "production-api" },
    { name = "production-cleanup" },
    { name = "production-images" },
    { name = "production-refresh" },
    { name = "production-refresh-failure" },
    { name = "production-accounts" },
    { name = "production-jwt" },
    { name = "production-config" },
  ]
}
