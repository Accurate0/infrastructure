resource "cloudflare_record" "ww3" {
  zone_id         = var.cloudflare_zone_id
  name            = "ww3"
  value           = "oracle1.anurag.sh"
  type            = "CNAME"
  ttl             = 1
  proxied         = true
  allow_overwrite = true
}

variable "cloudflare_zone_id" {
  type      = string
  sensitive = true
}
