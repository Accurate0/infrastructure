terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.6.2"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.9.0"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "~> 0.3"
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
    google = {
      source  = "hashicorp/google"
      version = "4.71.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }

  backend "s3" {
    key = "maccas/terraform.tfstate"
  }
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
  alias         = "adb2c"
}
