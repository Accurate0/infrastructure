variable "secret_name" {
  type = string
}

variable "secret_value" {
  type      = string
  sensitive = true
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

resource "azurerm_key_vault_secret" "this" {
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = data.azurerm_key_vault.kv.id
}
