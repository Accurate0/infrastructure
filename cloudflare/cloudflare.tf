variable "cloudflare_zone_id" {
  type      = string
  sensitive = true
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
