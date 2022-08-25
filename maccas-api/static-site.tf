resource "cloudflare_record" "maccas" {
  zone_id         = var.cloudflare_zone_id
  name            = "maccas"
  value           = "maccas-web.pages.dev"
  type            = "CNAME"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

variable "cloudflare_zone_id" {
  type      = string
  sensitive = true
  default   = "ccdf653cce6321100fecab81f8f2d9ff"
}
