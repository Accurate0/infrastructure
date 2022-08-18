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

module "points" {
  source           = "Accurate0/serverless-resource/aws"
  version          = "2.1.0"
  api_key_required = true
  api              = aws_api_gateway_rest_api.api.id
  root_resource    = aws_api_gateway_rest_api.api.root_resource_id
  resource         = "points"
  cors             = false
  methods = [
    {
      method     = "GET"
      type       = null
      invoke_arn = aws_lambda_function.api.invoke_arn
    }
  ]
}

module "accountId" {
  source           = "Accurate0/serverless-resource/aws"
  version          = "2.1.0"
  api_key_required = true
  api              = aws_api_gateway_rest_api.api.id
  root_resource    = module.points.resource
  resource         = "{accountId}"
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

module "docs" {
  source           = "Accurate0/serverless-resource/aws"
  version          = "2.1.0"
  api_key_required = true
  api              = aws_api_gateway_rest_api.api.id
  root_resource    = aws_api_gateway_rest_api.api.root_resource_id
  resource         = "docs"
  cors             = false
  methods          = []
}

module "openapi" {
  source           = "Accurate0/serverless-resource/aws"
  version          = "2.1.0"
  api_key_required = true
  api              = aws_api_gateway_rest_api.api.id
  root_resource    = module.docs.resource
  resource         = "openapi"
  cors             = false
  methods = [
    {
      method     = "GET"
      type       = null
      invoke_arn = aws_lambda_function.api.invoke_arn
    }
  ]
}


module "code" {
  source           = "Accurate0/serverless-resource/aws"
  version          = "2.1.0"
  api_key_required = true
  api              = aws_api_gateway_rest_api.api.id
  root_resource    = aws_api_gateway_rest_api.api.root_resource_id
  resource         = "code"
  cors             = false
  methods          = []
}


module "code-dealid" {
  source           = "Accurate0/serverless-resource/aws"
  version          = "2.1.0"
  api_key_required = true
  api              = aws_api_gateway_rest_api.api.id
  root_resource    = module.code.resource
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


module "deals" {
  source           = "Accurate0/serverless-resource/aws"
  version          = "2.1.0"
  api_key_required = true
  api              = aws_api_gateway_rest_api.api.id
  root_resource    = aws_api_gateway_rest_api.api.root_resource_id
  resource         = "deals"
  cors             = false
  methods = [
    {
      method     = "GET"
      type       = null
      invoke_arn = aws_lambda_function.api.invoke_arn
    }
  ]
}

module "deals-last-refresh" {
  source           = "Accurate0/serverless-resource/aws"
  version          = "2.1.0"
  api_key_required = true
  api              = aws_api_gateway_rest_api.api.id
  root_resource    = module.deals.resource
  resource         = "last-refresh"
  cors             = false
  methods = [
    {
      method     = "GET"
      type       = null
      invoke_arn = aws_lambda_function.api.invoke_arn
    }
  ]
}


module "deals-dealid" {
  source           = "Accurate0/serverless-resource/aws"
  version          = "2.1.0"
  api_key_required = true
  api              = aws_api_gateway_rest_api.api.id
  root_resource    = module.deals.resource
  resource         = "{dealId}"
  cors             = false
  methods = [
    {
      method     = "GET"
      type       = null
      invoke_arn = aws_lambda_function.api.invoke_arn
    },
    {
      method     = "POST"
      type       = null
      invoke_arn = aws_lambda_function.api.invoke_arn
    },
    {
      method     = "DELETE"
      type       = null
      invoke_arn = aws_lambda_function.api.invoke_arn
    }
  ]
}

module "locations" {
  source           = "Accurate0/serverless-resource/aws"
  version          = "2.1.0"
  api_key_required = true
  api              = aws_api_gateway_rest_api.api.id
  root_resource    = aws_api_gateway_rest_api.api.root_resource_id
  resource         = "locations"
  cors             = false
  methods = [
    {
      method     = "GET"
      type       = null
      invoke_arn = aws_lambda_function.api.invoke_arn
    }
  ]
}

module "locations-search" {
  source           = "Accurate0/serverless-resource/aws"
  version          = "2.1.0"
  api_key_required = true
  api              = aws_api_gateway_rest_api.api.id
  root_resource    = module.locations.resource
  resource         = "search"
  cors             = false
  methods = [
    {
      method     = "GET"
      type       = null
      invoke_arn = aws_lambda_function.api.invoke_arn
    }
  ]
}

module "user" {
  source           = "Accurate0/serverless-resource/aws"
  version          = "2.1.0"
  api_key_required = true
  api              = aws_api_gateway_rest_api.api.id
  root_resource    = aws_api_gateway_rest_api.api.root_resource_id
  resource         = "user"
  cors             = false
  methods          = []
}

module "user-config" {
  source           = "Accurate0/serverless-resource/aws"
  version          = "2.1.0"
  api_key_required = true
  api              = aws_api_gateway_rest_api.api.id
  root_resource    = module.user.resource
  resource         = "config"
  cors             = false
  methods = [
    {
      method     = "GET"
      type       = null
      invoke_arn = aws_lambda_function.api.invoke_arn
    },
    {
      method     = "POST"
      type       = null
      invoke_arn = aws_lambda_function.api.invoke_arn
    }
  ]
}
