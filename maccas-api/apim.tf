data "azurerm_resource_group" "general-api-group" {
  name = "general-api-group"
}

data "azurerm_api_management" "general-apim" {
  name                = "general-apim"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
}

resource "azurerm_api_management_api_version_set" "maccas-segment-version" {
  name                = "MaccasApiSegment"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "Maccas API"
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "maccas-v1" {
  name                  = "Maccas-API-v1"
  resource_group_name   = data.azurerm_resource_group.general-api-group.name
  api_management_name   = data.azurerm_api_management.general-apim.name
  revision              = "1"
  version               = "v1"
  display_name          = "Maccas API"
  path                  = "maccas"
  protocols             = ["https", "http"]
  subscription_required = true
  service_url           = aws_api_gateway_stage.api-stage.invoke_url
  version_set_id        = azurerm_api_management_api_version_set.maccas-segment-version.id

  subscription_key_parameter_names {
    header = "X-Api-Key"
    query  = "api-key"
  }
}

resource "azurerm_api_management_api_policy" "maccas-v1-policy" {
  api_name            = azurerm_api_management_api.maccas-v1.name
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_resource_group.general-api-group.name

  depends_on = [
    azurerm_api_management_named_value.maccas-lambda-api-key
  ]
  xml_content = file("policy/maccas.v1.policy.xml")
}

resource "azurerm_api_management_api_operation" "refresh-operation" {
  operation_id = "refresh"
  display_name = "Refresh Deals"
  url_template = "/deals/refresh"
  method       = "POST"

  api_name            = azurerm_api_management_api.maccas-v1.name
  api_management_name = azurerm_api_management_api.maccas-v1.api_management_name
  resource_group_name = azurerm_api_management_api.maccas-v1.resource_group_name
}
