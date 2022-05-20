data "azurerm_resource_group" "general-api-group" {
  name = "general-api-group"
}

data "azurerm_api_management" "general-apim" {
  name                = "general-apim"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
}

data "azurerm_api_management_api_version_set" "maccas-segment-version" {
  name                = "MaccasApiSegment"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
}

resource "azurerm_api_management_api" "maccas-v2" {
  name                  = "Maccas-API-v2"
  resource_group_name   = data.azurerm_resource_group.general-api-group.name
  api_management_name   = data.azurerm_api_management.general-apim.name
  revision              = "1"
  version               = "v2"
  display_name          = "Maccas API"
  path                  = "maccas"
  protocols             = ["https", "http"]
  subscription_required = false
  service_url           = aws_api_gateway_stage.api-stage.invoke_url
  version_set_id        = data.azurerm_api_management_api_version_set.maccas-segment-version.id

  subscription_key_parameter_names {
    header = "X-Api-Key"
    query  = "api-key"
  }
}

resource "azurerm_api_management_api_policy" "maccas-v2-policy" {
  api_name            = azurerm_api_management_api.maccas-v2.name
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_resource_group.general-api-group.name

  depends_on = [
    azurerm_api_management_named_value.maccas-lambda-api-key
  ]
  xml_content = file("policy/maccas.v2.policy.xml")
}
