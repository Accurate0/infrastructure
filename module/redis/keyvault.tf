data "azurerm_resource_group" "general-api-group" {
  name = "general-api-group"
}

data "azurerm_api_management" "general-apim" {
  name                = "general-apim"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
}

data "azurerm_key_vault" "kv" {
  name                = "gen-shared-kv"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
}

data "azurerm_key_vault_secret" "redis-cluster-password" {
  name         = "redis-cluster-password"
  key_vault_id = data.azurerm_key_vault.kv.id
}
