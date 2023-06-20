terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
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

output "lambda_arn" {
  value = aws_lambda_function.api.arn
}
