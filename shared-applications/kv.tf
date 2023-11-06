module "umami-database-connection" {
  source      = "../module/keyvault-value-output"
  secret_name = "umami-database-connection"
}

module "umami-app-secret" {
  source      = "../module/keyvault-value-output"
  secret_name = "umami-app-secret"
}
