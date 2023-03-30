module "maccas-apim-jwt-bypass" {
  source       = "../module/keyvault-named-value"
  named_value  = "MaccasJwtBypass"
  secret_name  = "maccas-apim-jwt-bypass"
  secret_value = base64encode(random_password.jwt-bypass-token.result)
}

module "maccas-lambda-dev-api-key" {
  source       = "../module/keyvault-named-value"
  named_value  = "MaccasLambdaDevApiKey"
  secret_name  = "maccas-lambda-dev-api-key"
  secret_value = base64encode(random_password.jwt-bypass-token.result)
}

module "maccas-lambda-api-key" {
  source       = "../module/keyvault-named-value"
  named_value  = "MaccasLambdaApiKey"
  secret_name  = "maccas-lambda-api-key"
  secret_value = base64encode(random_password.jwt-bypass-token.result)
}
