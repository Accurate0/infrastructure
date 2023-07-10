terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.7.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.63.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.9.0"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "~> 0.3"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "1.7.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.29.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.39.0"
    }
  }

  backend "s3" {
    key = "maccas/terraform.tfstate"
  }
}

provider "azapi" {}

provider "azurerm" {
  features {}
}

provider "aws" {
  default_tags {
    tags = {
      Project = "Maccas API"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
  default_tags {
    tags = {
      Project = "Maccas API"
    }
  }
}

provider "github" {}

provider "random" {}

variable "ARM_B2C_CLIENT_ID" {
  type = string
}

variable "ARM_B2C_CLIENT_SECRET" {
  type = string
}

variable "ARM_B2C_TENANT_ID" {
  type = string
}

provider "azuread" {
  client_id     = var.ARM_B2C_CLIENT_ID
  client_secret = var.ARM_B2C_CLIENT_SECRET
  tenant_id     = var.ARM_B2C_TENANT_ID
}
