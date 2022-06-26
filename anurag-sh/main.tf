terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.10.1"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "~> 0.3"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "anurag-sh"
    }
  }
}

variable "cloudflare_zone_id" {
  type      = string
  sensitive = true
}
