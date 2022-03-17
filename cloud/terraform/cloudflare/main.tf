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

resource "cloudflare_record" "root" {
  zone_id         = var.cloudflare_zone_id
  name            = "@"
  value           = "accurate0.github.io"
  type            = "CNAME"
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "www" {
  zone_id         = var.cloudflare_zone_id
  name            = "www"
  value           = "anurag.sh"
  type            = "CNAME"
  ttl             = 1
  allow_overwrite = true
}
