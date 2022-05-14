output "readonly_connection_string" {
  value     = "AccountEndpoint=${azurerm_cosmosdb_account.general-api-db.endpoint};AccountKey=${azurerm_cosmosdb_account.general-api-db.primary_readonly_key};"
  sensitive = true
}

output "connection_string" {
  value     = "AccountEndpoint=${azurerm_cosmosdb_account.general-api-db.endpoint};AccountKey=${azurerm_cosmosdb_account.general-api-db.primary_key};"
  sensitive = true
}
