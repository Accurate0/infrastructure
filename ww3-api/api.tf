resource "aws_apigatewayv2_api" "ww3-api" {
  name          = "ww3-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "ww3-api" {
  api_id = aws_apigatewayv2_api.ww3-api.id

  name        = "ww3-api"
  auto_deploy = true

  default_route_settings {
    throttling_burst_limit = 10
    throttling_rate_limit  = 10
  }

}

resource "aws_apigatewayv2_integration" "status" {
  api_id = aws_apigatewayv2_api.ww3-api.id

  integration_uri    = aws_lambda_function.ww3-api.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "status" {
  api_id = aws_apigatewayv2_api.ww3-api.id

  route_key = "GET /status"
  target    = "integrations/${aws_apigatewayv2_integration.status.id}"
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ww3-api.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.ww3-api.execution_arn}/*/*"
}
