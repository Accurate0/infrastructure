terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
  }
  cloud {
    organization = "server"
    workspaces {
      name = "ww3-api"
    }
  }
}

provider "aws" {}
provider "azurerm" {
  features {}
}
module "lambda" {
  source      = "../module/aws-lambda-http-trigger"
  api_name    = "WW3Api"
  api_runtime = "go1.x"
  api_handler = "main"
  api_routes  = ["GET /status"]
}
