resource "aws_apigatewayv2_api" "apigwv2" {
  name          = var.api_name
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "apigwv2-stage" {
  api_id = aws_apigatewayv2_api.apigwv2.id

  name        = var.api_name
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.cloudwatch-api-gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }

  default_route_settings {
    throttling_burst_limit = 10
    throttling_rate_limit  = 10
    logging_level          = "OFF"
  }
}

resource "aws_apigatewayv2_integration" "integration-proxy" {
  api_id = aws_apigatewayv2_api.apigwv2.id

  integration_uri    = aws_lambda_function.api.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "api-route" {
  api_id = aws_apigatewayv2_api.apigwv2.id

  route_key = var.api_routes[count.index]
  target    = "integrations/${aws_apigatewayv2_integration.integration-proxy.id}"
  count     = length(var.api_routes)
}

resource "aws_lambda_permission" "api-gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.apigwv2.execution_arn}/*/*"
}

resource "aws_cloudwatch_log_group" "cloudwatch-api-gw" {
  name = "/aws/api-gw/${aws_apigatewayv2_api.apigwv2.name}"

  retention_in_days = 30
}
