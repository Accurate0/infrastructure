resource "aws_apigatewayv2_domain_name" "this" {
  domain_name = "api.maccas.one"

  domain_name_configuration {
    certificate_arn = aws_acm_certificate.cert-api.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_apigatewayv2_api_mapping" "maccas-api" {
  api_id          = aws_apigatewayv2_api.this.id
  domain_name     = aws_apigatewayv2_domain_name.this.id
  stage           = "v1"
  api_mapping_key = "v1"
}

resource "aws_apigatewayv2_api" "this" {
  name                         = "Maccas API"
  protocol_type                = "HTTP"
  disable_execute_api_endpoint = true
  cors_configuration {
    allow_credentials = true
    allow_methods     = ["GET", "DELETE", "POST"]
    allow_origins     = ["http://localhost:3000", "https://old.maccas.one"]
    allow_headers     = ["Authorization", "Content-Type"]
    max_age           = 259200
  }
}

resource "aws_apigatewayv2_integration" "this" {
  api_id           = aws_apigatewayv2_api.this.id
  integration_type = "AWS_PROXY"

  integration_method     = "POST"
  integration_uri        = aws_lambda_function.api.invoke_arn
  payload_format_version = "2.0"

  request_parameters = {
    "overwrite:path" = "$request.path"
  }
}

resource "aws_apigatewayv2_stage" "this" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = "v1"
  auto_deploy = true
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api-gateway-log.arn
    format          = "[$context.extendedRequestId $context.identity.sourceIp $context.authorizer.claims.oid] $context.httpMethod $context.path - $context.status $context.responseLength completed in $context.responseLatency ms"
  }
}

resource "aws_lambda_permission" "api-gateway" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.this.execution_arn}/*/*"
}

resource "aws_lambda_permission" "api-gateway-jwt" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.jwt.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.this.execution_arn}/*/*"
}

resource "aws_apigatewayv2_authorizer" "this" {
  api_id                            = aws_apigatewayv2_api.this.id
  authorizer_type                   = "REQUEST"
  identity_sources                  = ["$request.header.Authorization"]
  name                              = "maccas-api-jwt"
  authorizer_uri                    = aws_lambda_function.jwt.invoke_arn
  authorizer_payload_format_version = "2.0"
  enable_simple_responses           = true
  authorizer_result_ttl_in_seconds  = 3600
}
