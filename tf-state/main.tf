terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.7.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.45.0"
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
