module "cosmodb-readonly-connection-string" {
  source      = "../module/keyvault-value-output"
  secret_name = "cosmodb-readonly-connection-string"
}

module "cosmodb-connection-string" {
  source      = "../module/keyvault-value-output"
  secret_name = "cosmodb-connection-string"
}
