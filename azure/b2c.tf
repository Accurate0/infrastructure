resource "azurerm_aadb2c_directory" "b2c" {
  data_residency_location = "Australia"
  domain_name             = "apib2clogin.onmicrosoft.com"
  resource_group_name     = "general-api-group"
  sku_name                = "PremiumP1"
}
