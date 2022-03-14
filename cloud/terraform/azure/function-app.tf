
resource "azurerm_storage_account" "weather-api-sa" {
  name                     = "weatherapifasa"
  resource_group_name      = azurerm_resource_group.weather-api-group.name
  location                 = azurerm_resource_group.weather-api-group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "weather-api-fa-appserviceplan" {
  name                = "weather-api-fa-appserviceplan"
  location            = azurerm_resource_group.weather-api-group.location
  resource_group_name = azurerm_resource_group.weather-api-group.name
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "weather-background-fa" {
  name                       = "weather-background-fa"
  location                   = azurerm_resource_group.weather-api-group.location
  resource_group_name        = azurerm_resource_group.weather-api-group.name
  app_service_plan_id        = azurerm_app_service_plan.weather-api-fa-appserviceplan.id
  storage_account_name       = azurerm_storage_account.weather-api-sa.name
  storage_account_access_key = azurerm_storage_account.weather-api-sa.primary_access_key
  version                    = "~4"
  https_only                 = true

  connection_string {
    name  = "Database"
    type  = "Custom"
    value = azurerm_cosmosdb_account.weather-api-db.connection_strings[0]
  }
}
