resource "aws_api_gateway_rest_api" "api" {
  name           = var.api_name
  api_key_source = "HEADER"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "api-deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  depends_on = [
    aws_api_gateway_rest_api.api,
    aws_api_gateway_integration.api-integration
  ]

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.api-resource,
      "${aws_api_gateway_method.api-method.*.id}",
      aws_api_gateway_integration.api-integration,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "api-stage" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.api-deployment.id
  stage_name    = "api"
}

resource "aws_api_gateway_method" "api-method" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.api-resource[count.index].id
  http_method      = var.api_routes[count.index].method
  api_key_required = true
  authorization    = "NONE"
  count            = length(var.api_routes)
}

resource "aws_api_gateway_integration" "api-integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.api-resource[count.index].id
  http_method             = aws_api_gateway_method.api-method[count.index].http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api.invoke_arn
  count                   = length(var.api_routes)
}

resource "aws_api_gateway_resource" "api-resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = var.api_routes[count.index].route
  count       = length(var.api_routes)
}

resource "aws_api_gateway_api_key" "api-key" {
  name = "${var.api_name}-key"
}

resource "aws_api_gateway_usage_plan_key" "usage-plan-key" {
  key_id        = aws_api_gateway_api_key.api-key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.api-usage.id
}

resource "aws_api_gateway_usage_plan" "api-usage" {
  name = "api-usage"

  api_stages {
    api_id = aws_api_gateway_rest_api.api.id
    stage  = aws_api_gateway_stage.api-stage.stage_name
  }
  quota_settings {
    limit  = 200
    period = "DAY"
  }

  throttle_settings {
    burst_limit = 5
    rate_limit  = 10
  }
}

resource "aws_lambda_permission" "api-gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}
