terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.62.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.10.1"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "~> 0.3"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "1.3.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.22.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.31.0"
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
