resource "azurerm_api_management_api_operation" "lamp-off" {
  operation_id        = "lamp-off"
  api_name            = azurerm_api_management_api.light-v1.name
  api_management_name = azurerm_api_management_api.light-v1.api_management_name
  resource_group_name = azurerm_api_management_api.light-v1.resource_group_name
  display_name        = "Lamp Off"
  method              = "POST"
  url_template        = "/lamp/off"

  response {
    status_code = 200
  }
}

resource "azurerm_api_management_api_operation" "lamp-on" {
  operation_id        = "lamp-on"
  api_name            = azurerm_api_management_api.light-v1.name
  api_management_name = azurerm_api_management_api.light-v1.api_management_name
  resource_group_name = azurerm_api_management_api.light-v1.resource_group_name
  display_name        = "Lamp On"
  method              = "POST"
  url_template        = "/lamp/on"

  response {
    status_code = 200
  }
}

resource "azurerm_api_management_api_operation" "lamp-state" {
  operation_id        = "light-state"
  api_name            = azurerm_api_management_api.light-v1.name
  api_management_name = azurerm_api_management_api.light-v1.api_management_name
  resource_group_name = azurerm_api_management_api.light-v1.resource_group_name
  display_name        = "Lamp Status"
  method              = "GET"
  url_template        = "/lamp/state"

  response {
    status_code = 200
  }
}
