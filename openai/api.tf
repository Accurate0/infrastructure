data "azurerm_resource_group" "general-api-group" {
  name = "general-api-group"
}

data "azurerm_api_management" "general-apim" {
  name                = "general-apim"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
}

resource "azurerm_api_management_api_version_set" "openai-segment-version" {
  name                = "OpenAIApiSegment"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "OpenAI API"
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "openai-v1" {
  name                  = "OpenAI-API-v1"
  resource_group_name   = data.azurerm_resource_group.general-api-group.name
  api_management_name   = data.azurerm_api_management.general-apim.name
  revision              = "1"
  version               = "v1"
  display_name          = "OpenAI API"
  path                  = "openai"
  protocols             = ["https", "http"]
  subscription_required = true
  subscription_key_parameter_names {
    header = "X-Api-Key"
    query  = "api-key"
  }

  service_url    = "https://api.openai.com/v1/"
  version_set_id = azurerm_api_management_api_version_set.openai-segment-version.id
}

resource "azurerm_api_management_api_policy" "openai-v1-policy" {
  api_name            = azurerm_api_management_api.openai-v1.name
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_resource_group.general-api-group.name

  xml_content = file("policy/base.policy.xml")
}
