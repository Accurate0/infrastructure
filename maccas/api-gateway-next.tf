resource "aws_apigatewayv2_api_mapping" "maccas-api-v2" {
  api_id          = aws_apigatewayv2_api.v2.id
  domain_name     = aws_apigatewayv2_domain_name.this.id
  stage           = "v2"
  api_mapping_key = "v2"
}

resource "aws_apigatewayv2_api" "v2" {
  name                         = "Maccas API V2"
  protocol_type                = "HTTP"
  disable_execute_api_endpoint = true

  cors_configuration {
    allow_credentials = true
    allow_methods     = ["GET", "DELETE", "POST"]
    allow_origins     = ["http://localhost:3000", "https://maccas.one", "https://next.maccas.one"]
    allow_headers     = ["Authorization", "Content-Type"]
    max_age           = 259200
  }
}

resource "aws_apigatewayv2_integration" "v2" {
  api_id           = aws_apigatewayv2_api.v2.id
  integration_type = "HTTP_PROXY"

  integration_method     = "ANY"
  integration_uri        = "https://maccas-api.fly.dev"

  request_parameters = {
    "overwrite:path" = "/v1/$request.path"
  }
}

resource "aws_apigatewayv2_stage" "v2" {
  api_id      = aws_apigatewayv2_api.v2.id
  name        = "v2"
  auto_deploy = true
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api-gateway-log.arn
    format          = "[$context.extendedRequestId $context.identity.sourceIp $context.authorizer.claims.oid] $context.httpMethod $context.path - $context.status $context.responseLength completed in $context.responseLatency ms"
  }
}

resource "aws_apigatewayv2_route" "any" {
  api_id             = aws_apigatewayv2_api.v2.id
  route_key          = "ANY /{proxy+}"
  target             = "integrations/${aws_apigatewayv2_integration.v2.id}"
  operation_name     = "ALL"
  authorization_type = "NONE"
}
