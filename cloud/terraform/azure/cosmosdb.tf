resource "azurerm_cosmosdb_account" "weather-api-db" {
  name                = "weather-api-cosmos-db"
  location            = azurerm_resource_group.weather-api-group.location
  resource_group_name = azurerm_resource_group.weather-api-group.name
  offer_type          = "Standard"

  enable_automatic_failover = true
  enable_free_tier          = true

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  geo_location {
    location          = azurerm_resource_group.weather-api-group.location
    failover_priority = 0
  }
}
