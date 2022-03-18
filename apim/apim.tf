
resource "azurerm_api_management" "general-apim" {
  name                = "general-apim"
  location            = azurerm_resource_group.general-api-group.location
  resource_group_name = azurerm_resource_group.general-api-group.name
  publisher_name      = "Anurag Singh"
  publisher_email     = "contact@anurag.sh"

  sku_name = "Consumption_0"
}

resource "azurerm_api_management_custom_domain" "general-apim-custom-domain" {
  api_management_id = azurerm_api_management.general-apim.id
  proxy {
    default_ssl_binding          = true
    host_name                    = "api.anurag.sh"
    negotiate_client_certificate = false
  }
}

resource "azurerm_resource_group" "general-api-group" {
  name     = "general-api-group"
  location = "australiaeast"
}

resource "azurerm_api_management_policy" "apim-base-policy" {
  api_management_id = azurerm_api_management.general-apim.id
  xml_content       = file("base.policy.xml")
}
