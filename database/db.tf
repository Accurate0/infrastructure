data "azurerm_resource_group" "general-api-group" {
  name = "general-api-group"
}

resource "azurerm_cosmosdb_account" "general-api-db" {
  name                = "general-api-db"
  location            = data.azurerm_resource_group.general-api-group.location
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  offer_type          = "Standard"

  enable_automatic_failover = true
  enable_free_tier          = true

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  capacity {
    total_throughput_limit = 1000
  }

  geo_location {
    location          = data.azurerm_resource_group.general-api-group.location
    failover_priority = 0
  }
}
