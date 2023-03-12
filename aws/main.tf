terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.11.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.3.0"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "aws"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      Project = "Shared Resource"
    }
  }
}
