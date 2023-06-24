terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.1.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.62.1"
    }
    github = {
      source  = "integrations/github"
      version = "5.28.1"
    }
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "1.8.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }

  backend "s3" {
    key = "ozb/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "aws" {
  default_tags {
    tags = {
      Project = "ozb"
    }
  }
}

provider "mongodbatlas" {
}
