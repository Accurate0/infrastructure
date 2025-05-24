terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.66"
    }
  }
  cloud {
    organization = "server"
    workspaces {
      name = "tfc"
    }
  }
}

provider "tfe" {}

provider "aws" {
  default_tags {
    tags = {
      Project = "Terraform State"
    }
  }
}
