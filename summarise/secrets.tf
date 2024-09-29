module "coolify-api-readonly-secret" {
  source      = "../module/keyvault-value-output"
  secret_name = "coolify-api-deploy-secret"
}

module "coolify-api-webhook" {
  source      = "../module/keyvault-value-output"
  secret_name = "coolify-api-summarise-webhook-url"
}
