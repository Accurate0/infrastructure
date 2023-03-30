data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                          = "gen-shared-kv"
  location                      = azurerm_resource_group.general-api-group.location
  resource_group_name           = azurerm_resource_group.general-api-group.name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled      = true
  public_network_access_enabled = true

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azurerm_user_assigned_identity.apim.principal_id

    secret_permissions = [
      "Get",
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List",
      "Create",
      "Delete",
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Restore"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = "47245261-7eb5-4a37-9d1a-a3805201ddde" # me

    key_permissions = [
      "Get",
      "List",
      "Create",
      "Delete",
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Restore"
    ]

  }
}
