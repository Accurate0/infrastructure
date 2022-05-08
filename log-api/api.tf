data "azurerm_resource_group" "general-api-group" {
  name = "general-api-group"
}

data "azurerm_api_management" "general-apim" {
  name                = "general-apim"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
}

resource "azurerm_api_management_api_version_set" "log-segment-version" {
  name                = "LogApiSegment"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "Log API"
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "log-v1" {
  name                  = "Log-API-v1"
  resource_group_name   = data.azurerm_resource_group.general-api-group.name
  api_management_name   = data.azurerm_api_management.general-apim.name
  revision              = "1"
  version               = "v1"
  display_name          = "Log API"
  path                  = "log"
  protocols             = ["https", "http"]
  subscription_required = true
  subscription_key_parameter_names {
    header = "X-Api-Key"
    query  = "api-key"
  }

  service_url    = "https://log-api.eu.newrelic.com/log/v1"
  version_set_id = azurerm_api_management_api_version_set.log-segment-version.id
}

resource "azurerm_api_management_api_policy" "log-v1-policy" {
  api_name            = azurerm_api_management_api.log-v1.name
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_resource_group.general-api-group.name

  xml_content = file("policy/base.policy.xml")
}

resource "azurerm_api_management_api_operation" "log-operation" {
  operation_id = "log"
  display_name = "Log"
  url_template = "/log"
  method       = "POST"

  api_name            = azurerm_api_management_api.log-v1.name
  api_management_name = azurerm_api_management_api.log-v1.api_management_name
  resource_group_name = azurerm_api_management_api.log-v1.resource_group_name
}

resource "azurerm_api_management_api_operation_policy" "log-operation-policy" {
  api_name            = azurerm_api_management_api_operation.log-operation.api_name
  api_management_name = azurerm_api_management_api_operation.log-operation.api_management_name
  resource_group_name = azurerm_api_management_api_operation.log-operation.resource_group_name
  operation_id        = azurerm_api_management_api_operation.log-operation.operation_id

  depends_on = [
    azurerm_api_management_named_value.newrelic-api-key
  ]

  xml_content = file("policy/log.policy.xml")
}
