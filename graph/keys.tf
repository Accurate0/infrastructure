resource "azurerm_api_management_named_value" "tenant-id" {
  name                = "b2c-tenant-id"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "B2CTenantId"
  secret              = true
  value               = var.ARM_B2C_TENANT_ID
}

resource "azurerm_api_management_named_value" "client-id" {
  name                = "b2c-client-id"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "B2CClientId"
  secret              = true
  value               = azuread_application.this.application_id
}

resource "azurerm_api_management_named_value" "client-secret" {
  name                = "b2c-client-secret"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "B2CClientSecret"
  secret              = true
  value               = azuread_application_password.this.value
}

resource "azurerm_api_management_named_value" "scope" {
  name                = "b2c-scope"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "B2CClientScope"
  secret              = false
  value               = "https://graph.microsoft.com/.default"
}
