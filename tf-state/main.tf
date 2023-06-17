terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.1.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.30.2"
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