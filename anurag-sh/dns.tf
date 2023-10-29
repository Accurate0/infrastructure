resource "cloudflare_record" "maccas" {
  zone_id         = var.cloudflare_zone_id
  name            = "maccas"
  value           = "anurag.sh"
  type            = "CNAME"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "vpn2" {
  zone_id = var.cloudflare_zone_id
  name    = "vpn2"
  value   = module.home-ip-kv.secret_value
  type    = "A"
  proxied = false
  ttl     = 1
}
