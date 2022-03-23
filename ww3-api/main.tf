terraform {
  cloud {
    organization = "server"
    workspaces {
      name = "ww3-api"
    }
  }
}

provider "aws" {}
module "lambda" {
  source      = "../module/aws-lambda-http-trigger"
  api_name    = "WW3Api"
  api_runtime = "go1.x"
  api_handler = "main"
  api_routes  = ["GET /status"]
}

output "http_endpoint" {
  value     = module.lambda.http_endpoint
  sensitive = true
}
