resource "azurerm_api_management" "general-apim" {
  name                = "general-apim"
  location            = azurerm_resource_group.general-api-group.location
  resource_group_name = azurerm_resource_group.general-api-group.name
  publisher_name      = "Anurag Singh"
  publisher_email     = "contact@anurag.sh"

  protocols {
    enable_http2 = true
  }

  sku_name = "Consumption_0"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.apim.id]
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_api_management_redis_cache" "general-apim-redis" {
  name              = "general-apim-redis"
  api_management_id = azurerm_api_management.general-apim.id
  connection_string = module.redis.cluster_stackexchange_connection_string
  cache_location    = azurerm_resource_group.general-api-group.location
}

resource "azurerm_resource_group" "general-api-group" {
  name     = "general-api-group"
  location = "australiaeast"
}

resource "azurerm_api_management_policy" "apim-base-policy" {
  api_management_id = azurerm_api_management.general-apim.id
  xml_content       = file("policy/base.policy.xml")
}
