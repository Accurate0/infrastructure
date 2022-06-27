data "azurerm_resource_group" "general-api-group" {
  name = "general-api-group"
}

data "azurerm_api_management" "general-apim" {
  name                = "general-apim"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
}

resource "azurerm_api_management_api_version_set" "dota2-segment-version" {
  name                = "Dota2ApiSegment"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "Dota 2 API"
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "dota2-v1" {
  name                  = "Dota2-API-v1"
  resource_group_name   = data.azurerm_resource_group.general-api-group.name
  api_management_name   = data.azurerm_api_management.general-apim.name
  revision              = "1"
  version               = "v1"
  display_name          = "Dota 2 API"
  path                  = "dota2"
  protocols             = ["https", "http"]
  subscription_required = true
  service_url           = aws_api_gateway_stage.api-stage.invoke_url
  version_set_id        = azurerm_api_management_api_version_set.dota2-segment-version.id

  subscription_key_parameter_names {
    header = "X-Api-Key"
    query  = "api-key"
  }
}

resource "azurerm_api_management_api_policy" "dota2-v1-policy" {
  api_name            = azurerm_api_management_api.dota2-v1.name
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_resource_group.general-api-group.name

  depends_on = [
    azurerm_api_management_named_value.dota2-lambda-api-key
  ]

  xml_content = file("policy/dota2.v1.policy.xml")
}
