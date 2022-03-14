
resource "azurerm_api_management" "general-apim" {
  name                = "general-apim"
  location            = azurerm_resource_group.general-api-group.location
  resource_group_name = azurerm_resource_group.general-api-group.name
  publisher_name      = "Anurag Singh"
  publisher_email     = "contact@anurag.sh"

  sku_name = "Consumption_0"

  protocols {
    enable_http2 = true
  }
}
