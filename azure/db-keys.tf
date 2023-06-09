module "db-readonly-connection-string" {
  source       = "../module/keyvault-value"
  secret_name  = "cosmodb-readonly-connection-string"
  secret_value = "AccountEndpoint=${azurerm_cosmosdb_account.general-api-db.endpoint};AccountKey=${azurerm_cosmosdb_account.general-api-db.primary_readonly_key};"
}

module "db-connection-string" {
  source       = "../module/keyvault-value"
  secret_name  = "cosmodb-connection-string"
  secret_value = "AccountEndpoint=${azurerm_cosmosdb_account.general-api-db.endpoint};AccountKey=${azurerm_cosmosdb_account.general-api-db.primary_key};"
}
