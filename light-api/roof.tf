resource "azurerm_api_management_api_operation" "roof-off" {
  operation_id        = "roof-off"
  api_name            = azurerm_api_management_api.light-v1.name
  api_management_name = azurerm_api_management_api.light-v1.api_management_name
  resource_group_name = azurerm_api_management_api.light-v1.resource_group_name
  display_name        = "Roof Off"
  method              = "POST"
  url_template        = "/roof/off"

  response {
    status_code = 200
  }
}

resource "azurerm_api_management_api_operation" "roof-on" {
  operation_id        = "roof-on"
  api_name            = azurerm_api_management_api.light-v1.name
  api_management_name = azurerm_api_management_api.light-v1.api_management_name
  resource_group_name = azurerm_api_management_api.light-v1.resource_group_name
  display_name        = "Roof On"
  method              = "POST"
  url_template        = "/roof/on"

  response {
    status_code = 200
  }
}

resource "azurerm_api_management_api_operation" "roof-state" {
  operation_id        = "roof-state"
  api_name            = azurerm_api_management_api.light-v1.name
  api_management_name = azurerm_api_management_api.light-v1.api_management_name
  resource_group_name = azurerm_api_management_api.light-v1.resource_group_name
  display_name        = "Roof Status"
  method              = "GET"
  url_template        = "/roof/state"

  response {
    status_code = 200
  }
}
