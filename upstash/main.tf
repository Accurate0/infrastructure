terraform {
  required_providers {
    upstash = {
      source  = "upstash/upstash"
      version = "1.3.0"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "upstash"
    }
  }
}

provider "upstash" {
  api_key = var.UPSTASH_API_KEY
  email   = var.UPSTASH_EMAIL
}

variable "UPSTASH_API_KEY" {
  type = string
}

variable "UPSTASH_EMAIL" {
  type = string
}
