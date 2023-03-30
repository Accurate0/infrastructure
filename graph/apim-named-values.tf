
resource "azurerm_api_management_named_value" "graph-user-property-select" {
  name                = "graph-user-property-select"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "GraphUserPropertySelect"
  secret              = false
  value               = "displayName,givenName,surname,extension_0bc691a1eb4c42f49cdf50357f8505b3_Role,id"
}

resource "azurerm_api_management_named_value" "tenant-id" {
  name                = "b2c-tenant-id"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "B2CTenantId"
  secret              = false
  value               = var.ARM_B2C_TENANT_ID
}

resource "azurerm_api_management_named_value" "client-id" {
  name                = "b2c-client-id"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "B2CClientId"
  secret              = false
  value               = azuread_application.this.application_id
}

resource "azurerm_api_management_named_value" "scope" {
  name                = "b2c-scope"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "B2CClientScope"
  secret              = false
  value               = "https://graph.microsoft.com/.default"
}
