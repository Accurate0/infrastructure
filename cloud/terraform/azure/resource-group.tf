resource "azurerm_resource_group" "weather-api-group" {
  name     = "weather-api-group"
  location = "australiaeast"
}

resource "azurerm_resource_group" "general-api-group" {
  name     = "general-api-group"
  location = "australiaeast"
}
