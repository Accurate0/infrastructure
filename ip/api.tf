data "azurerm_resource_group" "general-api-group" {
  name = "general-api-group"
}

data "azurerm_api_management" "general-apim" {
  name                = "general-apim"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
}

resource "azurerm_api_management_api_version_set" "ip-segment-version" {
  name                = "IPApiSegment"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "IP API"
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "ip-v1" {
  name                  = "IP-API-v1"
  resource_group_name   = data.azurerm_resource_group.general-api-group.name
  api_management_name   = data.azurerm_api_management.general-apim.name
  revision              = "1"
  version               = "v1"
  display_name          = "IP API"
  path                  = "ip"
  protocols             = ["https", "http"]
  subscription_required = false
  subscription_key_parameter_names {
    header = "X-Api-Key"
    query  = "api-key"
  }

  service_url    = ""
  version_set_id = azurerm_api_management_api_version_set.ip-segment-version.id
}

resource "azurerm_api_management_api_policy" "ip-v1-policy" {
  api_name            = azurerm_api_management_api.ip-v1.name
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_resource_group.general-api-group.name

  xml_content = file("policy/base.policy.xml")
}

resource "azurerm_api_management_api_operation" "ip-operation" {
  operation_id = "GetIP"
  display_name = "GetIP"
  url_template = "/ip"
  method       = "GET"

  api_name            = azurerm_api_management_api.ip-v1.name
  api_management_name = azurerm_api_management_api.ip-v1.api_management_name
  resource_group_name = azurerm_api_management_api.ip-v1.resource_group_name
}

resource "azurerm_api_management_api_operation_policy" "ip-operation-policy" {
  api_name            = azurerm_api_management_api_operation.ip-operation.api_name
  api_management_name = azurerm_api_management_api_operation.ip-operation.api_management_name
  resource_group_name = azurerm_api_management_api_operation.ip-operation.resource_group_name
  operation_id        = azurerm_api_management_api_operation.ip-operation.operation_id

  xml_content = file("policy/ip.policy.xml")
}
