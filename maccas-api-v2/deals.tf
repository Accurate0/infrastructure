resource "aws_api_gateway_stage" "api-stage" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.api-deployment.id
  stage_name    = "v2"
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
  uri                     = aws_lambda_function.api.invoke_arn
}

resource "aws_api_gateway_resource" "locations-api-resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "locations"
}

resource "aws_api_gateway_resource" "users-api-resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "user"
}

resource "aws_api_gateway_resource" "users-config-api-resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.users-api-resource.id
  path_part   = "config"
}

resource "aws_api_gateway_resource" "locations-search-api-resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.locations-api-resource.id
  path_part   = "search"
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

resource "aws_api_gateway_resource" "lock-api-resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.deals-api-resource.id
  path_part   = "lock"
}

resource "aws_api_gateway_resource" "last-refresh-api-resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.deals-api-resource.id
  path_part   = "last-refresh"
}

resource "aws_api_gateway_method" "lock-post-api-method" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.lock-api-resource.id
  http_method      = "POST"
  api_key_required = true
  authorization    = "NONE"
}

resource "aws_api_gateway_method" "locations-search-api-method" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.locations-search-api-resource.id
  http_method      = "GET"
  api_key_required = true
  authorization    = "NONE"
}

resource "aws_api_gateway_method" "user-config-get-api-method" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.users-config-api-resource.id
  http_method      = "GET"
  api_key_required = true
  authorization    = "NONE"
}

resource "aws_api_gateway_method" "user-config-patch-api-method" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.users-config-api-resource.id
  http_method      = "PATCH"
  api_key_required = true
  authorization    = "NONE"
}

resource "aws_api_gateway_method" "lock-delete-api-method" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.lock-api-resource.id
  http_method      = "DELETE"
  api_key_required = true
  authorization    = "NONE"
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

resource "aws_api_gateway_method" "last-refresh-api-method" {
  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.last-refresh-api-resource.id
  http_method      = "GET"
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

resource "aws_api_gateway_integration" "locations-get-api-integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.locations-api-resource.id
  http_method             = aws_api_gateway_method.locations-api-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api.invoke_arn
}

resource "aws_api_gateway_integration" "locations-search-post-api-integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.locations-search-api-resource.id
  http_method             = aws_api_gateway_method.locations-search-api-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api.invoke_arn
}

resource "aws_api_gateway_integration" "user-config-get-api-integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.users-config-api-resource.id
  http_method             = aws_api_gateway_method.user-config-get-api-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api.invoke_arn
}

resource "aws_api_gateway_integration" "user-config-patch-api-integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.users-config-api-resource.id
  http_method             = aws_api_gateway_method.user-config-patch-api-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api.invoke_arn
}

resource "aws_api_gateway_integration" "lock-post-api-integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.lock-api-resource.id
  http_method             = aws_api_gateway_method.lock-post-api-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api.invoke_arn
}

resource "aws_api_gateway_integration" "lock-delete-api-integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.lock-api-resource.id
  http_method             = aws_api_gateway_method.lock-delete-api-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api.invoke_arn
}

resource "aws_api_gateway_integration" "last-refresh-api-integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.last-refresh-api-resource.id
  http_method             = aws_api_gateway_method.last-refresh-api-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api.invoke_arn
}

resource "aws_api_gateway_resource" "deals-dealid-post-api-resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.deals-api-resource.id
  path_part   = "{dealId}"
}

resource "aws_api_gateway_resource" "code-dealid-get-api-resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.code-api-resource.id
  path_part   = "{dealId}"
}
