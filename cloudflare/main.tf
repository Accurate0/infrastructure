terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.10.1"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "cloudflare"
    }
  }
}

provider "cloudflare" {}
