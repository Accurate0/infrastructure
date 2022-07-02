module "statistics" {
  source           = "Accurate0/serverless-resource/aws"
  version          = "2.1.0"
  api_key_required = true
  api              = aws_api_gateway_rest_api.api.id
  root_resource    = aws_api_gateway_rest_api.api.root_resource_id
  resource         = "statistics"
  cors             = false
  methods          = []
}

module "deal" {
  source           = "Accurate0/serverless-resource/aws"
  version          = "2.1.0"
  api_key_required = true
  api              = aws_api_gateway_rest_api.api.id
  root_resource    = aws_api_gateway_rest_api.api.root_resource_id
  resource         = "deal"
  cors             = false
  methods          = []
}

module "dealId" {
  source           = "Accurate0/serverless-resource/aws"
  version          = "2.1.0"
  api_key_required = true
  api              = aws_api_gateway_rest_api.api.id
  root_resource    = module.deal.resource
  resource         = "{dealId}"
  cors             = false
  methods = [
    {
      method     = "GET"
      type       = null
      invoke_arn = aws_lambda_function.api.invoke_arn
    }
  ]
}

module "account" {
  source           = "Accurate0/serverless-resource/aws"
  version          = "2.1.0"
  api_key_required = true
  api              = aws_api_gateway_rest_api.api.id
  root_resource    = module.statistics.resource
  resource         = "account"
  cors             = false
  methods = [
    {
      method     = "GET"
      type       = null
      invoke_arn = aws_lambda_function.api.invoke_arn
    }
  ]
}

module "total-accounts" {
  source           = "Accurate0/serverless-resource/aws"
  version          = "2.1.0"
  api_key_required = true
  api              = aws_api_gateway_rest_api.api.id
  root_resource    = module.statistics.resource
  resource         = "total-accounts"
  cors             = false
  methods = [
    {
      method     = "GET"
      type       = null
      invoke_arn = aws_lambda_function.api.invoke_arn
    }
  ]
}
