
resource "aws_lambda_function" "api-dev" {
  function_name = "MaccasApi-api-dev"
  handler       = "bootstrap"
  role          = aws_iam_role.iam.arn
  filename      = data.archive_file.dummy.output_path
  timeout       = 30
  memory_size   = 256
  runtime       = "provided.al2"
  layers        = ["arn:aws:lambda:ap-southeast-2:753240598075:layer:LambdaAdapterLayerX86:16"]
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

resource "aws_api_gateway_rest_api" "api-dev" {
  name           = "MaccasApi-dev/v1"
  api_key_source = "HEADER"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_stage" "api-dev-stage" {
  rest_api_id   = aws_api_gateway_rest_api.api-dev.id
  deployment_id = aws_api_gateway_deployment.api-dev-deployment.id
  stage_name    = "v1"
}

resource "aws_api_gateway_deployment" "api-dev-deployment" {
  rest_api_id = aws_api_gateway_rest_api.api-dev.id
  depends_on = [
    aws_api_gateway_rest_api.api-dev,
    aws_api_gateway_resource.api-dev-gateway-wildcard,
    aws_api_gateway_method.api-dev-gateway-wildcard,
    aws_api_gateway_integration.api-dev-gateway-wildcard,
  ]

  triggers = {
    redeployment = jsonencode([filesha1("dev.tf"), filesha1("lambda.tf")])
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_api_key" "api-dev-key" {
  name = "MaccasApi-dev-key"
}

resource "aws_api_gateway_usage_plan_key" "usage-plan-dev-key" {
  key_id        = aws_api_gateway_api_key.api-dev-key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.api-dev-usage.id
}

resource "aws_api_gateway_usage_plan" "api-dev-usage" {
  name = "maccas-api-dev-usage"

  depends_on = [
    aws_api_gateway_stage.api-dev-stage
  ]

  api_stages {
    api_id = aws_api_gateway_rest_api.api-dev.id
    stage  = aws_api_gateway_stage.api-dev-stage.stage_name
  }
  quota_settings {
    limit  = 2000
    period = "DAY"
  }

  throttle_settings {
    burst_limit = 50
    rate_limit  = 5
  }
}

resource "aws_lambda_permission" "api-dev-gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api-dev.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api-dev.execution_arn}/*/*"
}

resource "aws_api_gateway_resource" "api-dev-gateway-wildcard" {
  rest_api_id = aws_api_gateway_rest_api.api-dev.id
  parent_id   = aws_api_gateway_rest_api.api-dev.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "api-dev-gateway-wildcard" {
  rest_api_id      = aws_api_gateway_rest_api.api-dev.id
  resource_id      = aws_api_gateway_resource.api-dev-gateway-wildcard.id
  http_method      = "ANY"
  authorization    = "NONE"
  api_key_required = true
}

resource "aws_api_gateway_integration" "api-dev-gateway-wildcard" {
  rest_api_id = aws_api_gateway_rest_api.api-dev.id
  resource_id = aws_api_gateway_resource.api-dev-gateway-wildcard.id
  http_method = "ANY"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api-dev.invoke_arn
}
