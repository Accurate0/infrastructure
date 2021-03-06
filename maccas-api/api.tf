resource "aws_api_gateway_rest_api" "api" {
  name           = "MaccasApi/v1"
  api_key_source = "HEADER"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "api-deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  depends_on = [
    aws_api_gateway_rest_api.api,

    aws_api_gateway_resource.deals-api-resource,
    aws_api_gateway_resource.code-api-resource,
    aws_api_gateway_resource.code-dealid-get-api-resource,
    aws_api_gateway_resource.deals-dealid-post-api-resource,
    aws_api_gateway_resource.locations-api-resource,
    aws_api_gateway_resource.lock-api-resource,
    aws_api_gateway_resource.users-api-resource,
    aws_api_gateway_resource.users-config-api-resource,
    aws_api_gateway_resource.locations-search-api-resource,
    aws_api_gateway_resource.last-refresh-api-resource,

    aws_api_gateway_method.deals-api-method,
    aws_api_gateway_method.code-api-method,
    aws_api_gateway_method.deals-delete-api-method,
    aws_api_gateway_method.deals-post-api-method,
    aws_api_gateway_method.locations-api-method,
    aws_api_gateway_method.lock-post-api-method,
    aws_api_gateway_method.lock-delete-api-method,
    aws_api_gateway_method.locations-search-api-method,
    aws_api_gateway_method.user-config-get-api-method,
    aws_api_gateway_method.user-config-post-api-method,
    aws_api_gateway_method.last-refresh-api-method,

    aws_api_gateway_integration.deals-api-integration,
    aws_api_gateway_integration.deals-delete-api-integration,
    aws_api_gateway_integration.code-get-api-integration,
    aws_api_gateway_integration.locations-get-api-integration,
    aws_api_gateway_integration.lock-post-api-integration,
    aws_api_gateway_integration.lock-delete-api-integration,
    aws_api_gateway_integration.locations-search-post-api-integration,
    aws_api_gateway_integration.user-config-get-api-integration,
    aws_api_gateway_integration.user-config-post-api-integration,
    aws_api_gateway_integration.last-refresh-api-integration,

    module.statistics,
    module.account,
    module.total-accounts,
    module.deal,
    module.dealId,
    module.points,
    module.accountId,
    module.docs,
    module.openapi,
  ]

  triggers = {
    redeployment = jsonencode([filesha1("deals.tf"), filesha1("api.tf"), filesha1("endpoints.tf")])
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_api_key" "api-key" {
  name = "MaccasApi-key"
}

resource "aws_api_gateway_usage_plan_key" "usage-plan-key" {
  key_id        = aws_api_gateway_api_key.api-key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.api-usage.id
}

resource "aws_api_gateway_usage_plan" "api-usage" {
  name = "maccas-api-usage"

  depends_on = [
    aws_api_gateway_stage.api-stage
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
