data "azurerm_resource_group" "general-api-group" {
  name = "general-api-group"
}

data "azurerm_api_management" "general-apim" {
  name                = "general-apim"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
}

resource "azurerm_api_management_api_version_set" "weather-segment-version" {
  name                = "WeatherApiSegment"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "Weather API"
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "weather-v1" {
  name                  = "Weather-API-v1"
  resource_group_name   = data.azurerm_resource_group.general-api-group.name
  api_management_name   = data.azurerm_api_management.general-apim.name
  revision              = "1"
  version               = "v1"
  display_name          = "Weather API"
  path                  = "weather"
  protocols             = ["https", "http"]
  subscription_required = false
  service_url           = "https://${azurerm_app_service.weather-api.name}.azurewebsites.net"
  version_set_id        = azurerm_api_management_api_version_set.weather-segment-version.id
}

resource "azurerm_api_management_api_policy" "weather-v1-policy" {
  api_name            = azurerm_api_management_api.weather-v1.name
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_resource_group.general-api-group.name

  xml_content = file("policy/weather.policy.xml")
}
