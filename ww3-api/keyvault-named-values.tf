module "ww3-lambda-api-key" {
  source       = "../module/keyvault-named-value"
  named_value  = "WW3LambdaApiKey"
  secret_name  = "ww3-lambda-api-key"
  secret_value = module.lambda.api_key
}
