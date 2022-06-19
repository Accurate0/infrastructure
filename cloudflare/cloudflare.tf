variable "cloudflare_zone_id" {
  type      = string
  sensitive = true
}

resource "cloudflare_record" "root" {
  zone_id         = var.cloudflare_zone_id
  name            = "@"
  value           = "accurate0.github.io"
  type            = "CNAME"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "www" {
  zone_id         = var.cloudflare_zone_id
  name            = "www"
  value           = "anurag.sh"
  type            = "CNAME"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "znc" {
  zone_id         = var.cloudflare_zone_id
  name            = "znc"
  value           = "oracle1.anurag.sh"
  type            = "CNAME"
  proxied         = false
  ttl             = 1
  allow_overwrite = true
}
