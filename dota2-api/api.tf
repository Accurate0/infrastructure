resource "aws_api_gateway_rest_api" "api" {
  name           = "Dota2/v1"
  api_key_source = "HEADER"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "api-deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  depends_on = [
    aws_api_gateway_rest_api.api,
    aws_api_gateway_resource.match-resource,
    aws_api_gateway_method.match-get-method,
    aws_api_gateway_integration.match-get-api-integration,
  ]

  triggers = {
    redeployment = jsonencode([filesha1("api.tf")])
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_api_key" "api-key" {
  name = "dota2-key"
}

resource "aws_api_gateway_usage_plan_key" "usage-plan-key" {
  key_id        = aws_api_gateway_api_key.api-key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.api-usage.id
}

resource "aws_api_gateway_usage_plan" "api-usage" {
  name = "dota2-api-usage"

  depends_on = [
    aws_api_gateway_stage.api-stage,
  ]

  api_stages {
    api_id = aws_api_gateway_rest_api.api.id
    stage  = aws_api_gateway_stage.api-stage.stage_name
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

resource "aws_lambda_permission" "api-gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

resource "aws_api_gateway_stage" "api-stage" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.api-deployment.id
  stage_name    = "v1"
}

resource "aws_api_gateway_resource" "match-resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "match"
}

resource "aws_api_gateway_resource" "matchId-resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.match-resource.id
  path_part   = "{matchId}"
}

resource "aws_api_gateway_method" "match-get-method" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.matchId-resource.id
  http_method      = "GET"
  api_key_required = true
  authorization    = "NONE"
}

resource "aws_api_gateway_integration" "match-get-api-integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.matchId-resource.id
  http_method             = aws_api_gateway_method.match-get-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api.invoke_arn
}
