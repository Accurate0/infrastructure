resource "azurerm_api_management_named_value" "google-places-api-key" {
  name                = "google-places-api-key"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "GooglePlacesApiKey"
  secret              = true
  value               = "VALUE_REPLACED_IN_PORTAL"
  lifecycle {
    ignore_changes = [value]
  }
}
