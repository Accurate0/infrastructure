resource "aws_lambda_function" "api-dev" {
  function_name = "MaccasApi-api-dev"
  handler       = "bootstrap"
  role          = aws_iam_role.iam.arn
  filename      = data.archive_file.dummy.output_path
  timeout       = 30
  memory_size   = 256
  runtime       = "provided.al2"
  layers        = ["arn:aws:lambda:ap-southeast-2:753240598075:layer:LambdaAdapterLayerX86:17"]
  environment {
    variables = {
      "AWS_LAMBDA_EXEC_WRAPPER"      = "/opt/bootstrap"
      "RUST_LOG"                     = "debug"
      "AWS_LWA_PORT"                 = "8000"
      "PORT"                         = "8000"
      "AWS_LWA_READINESS_CHECK_PATH" = "/health/status"
    }
  }
}
resource "aws_apigatewayv2_domain_name" "this-dev" {
  domain_name = "api.dev.maccas.one"

  domain_name_configuration {
    certificate_arn = aws_acm_certificate.cert-api-dev.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_apigatewayv2_api_mapping" "maccas-api-dev" {
  api_id          = aws_apigatewayv2_api.this-dev.id
  domain_name     = aws_apigatewayv2_domain_name.this-dev.id
  stage           = "v1"
  api_mapping_key = "v1"
}

resource "aws_apigatewayv2_api" "this-dev" {
  name                         = "Maccas API (DEV)"
  protocol_type                = "HTTP"
  disable_execute_api_endpoint = true
  cors_configuration {
    allow_credentials = true
    allow_methods     = ["GET", "DELETE", "POST"]
    allow_origins     = ["http://localhost:5173", "https://dev.maccas.one"]
    allow_headers     = ["Authorization", "Content-Type"]
    max_age           = 259200
  }
}

resource "aws_apigatewayv2_integration" "this-dev" {
  api_id           = aws_apigatewayv2_api.this-dev.id
  integration_type = "AWS_PROXY"

  integration_method     = "POST"
  integration_uri        = aws_lambda_function.api-dev.invoke_arn
  payload_format_version = "2.0"

  request_parameters = {
    "overwrite:path" = "$request.path"
  }
}

resource "aws_apigatewayv2_stage" "this-dev" {
  api_id      = aws_apigatewayv2_api.this-dev.id
  name        = "v1"
  auto_deploy = true
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api-gateway-log-dev.arn
    format          = "[$context.extendedRequestId $context.identity.sourceIp $context.authorizer.claims.oid] $context.httpMethod $context.path - $context.status $context.responseLength completed in $context.responseLatency ms"
  }
}

resource "aws_lambda_permission" "api-gateway-dev" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api-dev.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.this-dev.execution_arn}/*/*"
}

resource "aws_lambda_permission" "api-gateway-jwt-dev" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.jwt.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.this-dev.execution_arn}/*/*"
}

resource "aws_apigatewayv2_authorizer" "this-dev" {
  api_id                            = aws_apigatewayv2_api.this-dev.id
  authorizer_type                   = "REQUEST"
  name                              = "maccas-api-jwt-dev"
  authorizer_uri                    = aws_lambda_function.jwt.invoke_arn
  authorizer_payload_format_version = "2.0"
  enable_simple_responses           = true
  authorizer_result_ttl_in_seconds  = 0
}
