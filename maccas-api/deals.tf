resource "aws_api_gateway_stage" "api-stage" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.api-deployment.id
  stage_name    = "v1"
}

resource "aws_api_gateway_method" "locations-api-method" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.locations-api-resource.id
  http_method      = "GET"
  api_key_required = true
  authorization    = "NONE"
}
resource "aws_api_gateway_method" "deals-api-method" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.deals-api-resource.id
  http_method      = "GET"
  api_key_required = true
  authorization    = "NONE"
}

resource "aws_api_gateway_method" "code-api-method" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.code-dealid-get-api-resource.id
  http_method      = "GET"
  api_key_required = true
  authorization    = "NONE"
}

resource "aws_api_gateway_integration" "deals-api-integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.deals-api-resource.id
  http_method             = aws_api_gateway_method.deals-api-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api-deals.invoke_arn
}

resource "aws_api_gateway_resource" "locations-api-resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "locations"
}

resource "aws_api_gateway_resource" "deals-api-resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "deals"
}

resource "aws_api_gateway_resource" "code-api-resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "code"
}

resource "aws_api_gateway_method" "deals-post-api-method" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.deals-dealid-post-api-resource.id
  http_method      = "POST"
  api_key_required = true
  authorization    = "NONE"
}

resource "aws_api_gateway_method" "deals-delete-api-method" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.deals-dealid-post-api-resource.id
  http_method      = "DELETE"
  api_key_required = true
  authorization    = "NONE"
}

resource "aws_api_gateway_method" "deals-refresh-api-method" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.deals-refresh-post-api-resource.id
  http_method      = "POST"
  api_key_required = true
  authorization    = "NONE"
}

resource "aws_api_gateway_integration" "deals-post-api-integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.deals-dealid-post-api-resource.id
  http_method             = aws_api_gateway_method.deals-post-api-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api.invoke_arn
}

resource "aws_api_gateway_integration" "deals-delete-api-integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.deals-dealid-post-api-resource.id
  http_method             = aws_api_gateway_method.deals-delete-api-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api.invoke_arn
}

resource "aws_api_gateway_integration" "code-get-api-integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.code-dealid-get-api-resource.id
  http_method             = aws_api_gateway_method.code-api-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api.invoke_arn
}

resource "aws_api_gateway_integration" "deals-refresh-api-integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.deals-refresh-post-api-resource.id
  http_method             = aws_api_gateway_method.deals-refresh-api-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api-refresh.invoke_arn
}
resource "aws_api_gateway_integration" "locations-get-api-integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.locations-api-resource.id
  http_method             = aws_api_gateway_method.locations-api-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api-deals.invoke_arn
}
resource "aws_api_gateway_resource" "deals-dealid-post-api-resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.deals-api-resource.id
  path_part   = "{dealId}"
}

resource "aws_api_gateway_resource" "deals-refresh-post-api-resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.deals-api-resource.id
  path_part   = "refresh"
}

resource "aws_api_gateway_resource" "code-dealid-get-api-resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.code-api-resource.id
  path_part   = "{dealId}"
}
