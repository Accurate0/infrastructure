variable "secret_name" {
  type = string
}

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

data "azurerm_key_vault_secret" "this" {
  name         = var.secret_name
  key_vault_id = data.azurerm_key_vault.kv.id
}

output "secret_value" {
  value     = data.azurerm_key_vault_secret.this.value
  sensitive = true
}
