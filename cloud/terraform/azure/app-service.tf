resource "azurerm_app_service_plan" "weather-api-appserviceplan" {
  name                = "weather-api-appserviceplan"
  location            = azurerm_resource_group.weather-api-group.location
  resource_group_name = azurerm_resource_group.weather-api-group.name

  sku {
    tier = "FREE"
    size = "F1"
  }
}

resource "azurerm_app_service" "weather-api" {
  name                = "weather-api-app-service"
  location            = azurerm_resource_group.weather-api-group.location
  resource_group_name = azurerm_resource_group.weather-api-group.name
  app_service_plan_id = azurerm_app_service_plan.weather-api-appserviceplan.id

  source_control {
    repo_url           = "https://github.com/Accurate0/weather-api.git"
    branch             = "main"
    manual_integration = true
    use_mercurial      = false
  }

  connection_string {
    name  = "Database"
    type  = "DocDb"
    value = azurerm_cosmosdb_account.weather-api-db.connection_strings[0]
  }
}
