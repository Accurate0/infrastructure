resource "azurerm_app_service_plan" "weather-api-appserviceplan" {
  name                = "weather-api-appserviceplan"
  location            = azurerm_resource_group.weather-api.location
  resource_group_name = azurerm_resource_group.weather-api.name

  sku {
    tier = "FREE"
    size = "F1"
  }
}

resource "azurerm_app_service" "weather-api-app-service" {
  name                = "weather-api-app-service"
  location            = azurerm_resource_group.weather-api.location
  resource_group_name = azurerm_resource_group.weather-api.name
  app_service_plan_id = azurerm_app_service_plan.weather-api-appserviceplan.id

  source_control {
    repo_url           = "https://github.com/Accurate0/weather-api.git"
    branch             = "main"
    manual_integration = true
    use_mercurial      = false
  }
}
