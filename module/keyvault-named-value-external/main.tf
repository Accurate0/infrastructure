variable "secret_name" {
  type = string
}

variable "named_value" {
  type = string
}

variable "secret_value" {
  type      = string
  sensitive = true
  default   = "VALUE_REPLACED_IN_PORTAL"
}

data "azurerm_resource_group" "general-api-group" {
  name = "general-api-group"
}

data "azurerm_api_management" "general-apim" {
  name                = "general-apim"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
}

data "azurerm_user_assigned_identity" "umi" {
  name                = "general-apim-umi"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
}

data "azurerm_key_vault" "kv" {
  name                = "gen-shared-kv"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
}

resource "azurerm_api_management_named_value" "this" {
  name                = var.secret_name
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = var.named_value
  secret              = true
  value_from_key_vault {
    secret_id          = azurerm_key_vault_secret.this.versionless_id
    identity_client_id = data.azurerm_user_assigned_identity.umi.client_id
  }
}

resource "azurerm_key_vault_secret" "this" {
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = data.azurerm_key_vault.kv.id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
