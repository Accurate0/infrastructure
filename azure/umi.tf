resource "azurerm_user_assigned_identity" "apim" {
  location            = azurerm_resource_group.general-api-group.location
  name                = "general-apim-umi"
  resource_group_name = azurerm_resource_group.general-api-group.name
}
