resource "azurerm_api_management_subscription" "light-subscription" {
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_api_management.general-apim.resource_group_name
  api_id              = azurerm_api_management_api.light-v1.id
  display_name        = "Light API"
  state               = "active"
}

variable "home_assistant_api_key" {
  type      = string
  sensitive = true
}

resource "azurerm_api_management_named_value" "home-assistant-api-key" {
  name                = "home-assistant-api-key"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "HomeAssistantApiKey"
  secret              = true
  value               = var.home_assistant_api_key
}
