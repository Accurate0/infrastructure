resource "cloudflare_record" "maccas" {
  zone_id         = var.cloudflare_zone_id
  name            = "maccas"
  value           = "anurag.sh"
  type            = "CNAME"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}
