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
    azurerm_api_management_named_value.maccas-lambda-api-key,
    azurerm_api_management_named_value.maccas-lambda-dev-api-key
  ]
  xml_content = file("policy/maccas.v1.policy.xml")
}

module "apim-endpoints" {
  source              = "../module/apim-endpoints"
  api_name            = azurerm_api_management_api.maccas-v1.name
  api_management_name = azurerm_api_management_api.maccas-v1.api_management_name
  resource_group_name = azurerm_api_management_api.maccas-v1.resource_group_name
  api_definition      = jsondecode(file("apim-endpoints.json"))

  depends_on = [
    azapi_resource.maccas-jwt-verification-policy-fragment
  ]
}

resource "azapi_resource" "maccas-jwt-bypass-policy-fragment" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2021-12-01-preview"
  name      = "maccas-jwt-bypass-policy"
  parent_id = data.azurerm_api_management.general-apim.id

  body = jsonencode({
    properties = {
      description = "maccas-jwt-bypass-policy"
      format      = "rawxml"
      value       = file("policy/bypass.fragment.policy.xml")
    }
  })
}

resource "azapi_resource" "maccas-jwt-verification-policy-fragment" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2021-12-01-preview"
  name      = "maccas-jwt-verification-policy"
  parent_id = data.azurerm_api_management.general-apim.id

  body = jsonencode({
    properties = {
      description = "maccas-jwt-verification-policy"
      format      = "rawxml"
      value       = file("policy/verification.fragment.policy.xml")
    }
  })
}
