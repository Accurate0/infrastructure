resource "azurerm_app_service_plan" "weather-api-appserviceplan" {
  name                = "weather-api-appserviceplan"
  location            = azurerm_resource_group.weather-api-group.location
  resource_group_name = azurerm_resource_group.weather-api-group.name

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "weather-api" {
  name                = "weather-api-app-service"
  location            = azurerm_resource_group.weather-api-group.location
  resource_group_name = azurerm_resource_group.weather-api-group.name
  app_service_plan_id = azurerm_app_service_plan.weather-api-appserviceplan.id

  logs {
    application_logs {
      file_system_level = "Verbose"
    }
  }

  connection_string {
    name  = "Database"
    type  = "Custom"
    value = data.terraform_remote_state.database.outputs.readonly_connection_string
  }
}
