resource "azurerm_api_management_named_value" "maccas-lambda-api-key" {
  name                = "maccas-lambda-api-key"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "MaccasLambdaApiKey"
  secret              = true
  value               = aws_api_gateway_api_key.api-key.value
}

resource "azurerm_api_management_named_value" "maccas-lambda-dev-api-key" {
  name                = "maccas-lambda-dev-api-key"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "MaccasLambdaDevApiKey"
  secret              = true
  value               = aws_api_gateway_api_key.api-dev-key.value
}

resource "azurerm_api_management_named_value" "maccas-dev-backend-url" {
  name                = "maccas-dev-backend-url"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "MaccasDevBackendUrl"
  secret              = true
  value               = aws_api_gateway_stage.api-dev-stage.invoke_url
}

resource "azurerm_api_management_named_value" "maccas-apim-jwt-bypass" {
  name                = "maccas-apim-jwt-bypass"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "MaccasJwtBypass"
  secret              = true
  value               = base64encode(random_password.jwt-bypass-token.result)
}

resource "azurerm_api_management_named_value" "maccas-ad-client-id" {
  name                = "maccas-ad-client-id"
  resource_group_name = data.azurerm_resource_group.general-api-group.name
  api_management_name = data.azurerm_api_management.general-apim.name
  display_name        = "MaccasAdClientId"
  value               = azuread_application.this.application_id
}

resource "random_password" "jwt-bypass-token" {
  length  = 128
  special = true
}
