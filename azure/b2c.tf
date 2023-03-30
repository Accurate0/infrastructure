resource "azurerm_aadb2c_directory" "b2c" {
  data_residency_location = "Australia"
  domain_name             = "apib2clogin.onmicrosoft.com"
  resource_group_name     = azurerm_resource_group.general-api-group.name
  sku_name                = "PremiumP1"

  lifecycle {
    prevent_destroy = true
  }
}
