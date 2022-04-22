data "azurerm_resource_group" "general-api-group" {
  name = "general-api-group"
}

data "azurerm_api_management" "general-apim" {
  name                = "general-apim"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
}

data "azurerm_application_insights" "general-ai" {
  name                = "general-ai"
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
  subscription_required = false
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

resource "azurerm_api_management_logger" "maccas-apim-logger" {
  name                = "maccas-apim-logger"
  api_management_name = data.azurerm_api_management.general-apim.name
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  resource_id         = data.azurerm_application_insights.general-ai.id
  buffered            = false
  application_insights {
    instrumentation_key = data.azurerm_application_insights.general-ai.instrumentation_key
  }
}

resource "azurerm_api_management_api_diagnostic" "maccas-api-diag" {
  identifier               = "applicationinsights"
  resource_group_name      = data.azurerm_resource_group.general-api-group.name
  api_management_name      = data.azurerm_api_management.general-apim.name
  api_name                 = azurerm_api_management_api.maccas-v1.name
  api_management_logger_id = azurerm_api_management_logger.maccas-apim-logger.id

  sampling_percentage       = 100.0
  always_log_errors         = true
  log_client_ip             = true
  verbosity                 = "verbose"
  http_correlation_protocol = "W3C"
}
