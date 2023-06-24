terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.5.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.10.1"
    }
    github = {
      source  = "integrations/github"
      version = "5.22.0"
    }
  }

  backend "s3" {
    key = "ww3/terraform.tfstate"
  }
}

provider "aws" {}

provider "azurerm" {
  features {}
}

module "lambda" {
  source         = "../module/deprecated/aws-lambda-rest-trigger"
  api_name       = "WW3Api"
  api_version    = "v2"
  lambda_runtime = "go1.x"
  lambda_handler = "main"
  api_routes     = [{ method = "GET", route = "status" }]
}
