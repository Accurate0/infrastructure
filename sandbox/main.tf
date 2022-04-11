terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "sandbox"
    }
  }
}

provider "aws" {}
module "lambda" {
  source         = "../module/aws-lambda-rest-trigger"
  api_name       = "TestApi"
  api_version    = "v1"
  lambda_runtime = "go1.x"
  lambda_handler = "main"
  api_routes     = [{ method = "ANY", route = "reply" }]
}
