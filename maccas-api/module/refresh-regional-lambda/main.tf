terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.54.0"
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Project = "Maccas API"
    }
  }
}

variable "region" {
  type = string
}

variable "role_arn" {
  type = string
}
