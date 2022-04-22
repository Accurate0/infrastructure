
resource "azurerm_application_insights" "general-ai" {
  name                 = "general-ai"
  location             = azurerm_resource_group.general-api-group.location
  resource_group_name  = azurerm_resource_group.general-api-group.name
  application_type     = "other"
  retention_in_days    = 30
  daily_data_cap_in_gb = 0.166
  disable_ip_masking   = true
}
