resource "cloudflare_record" "api" {
  zone_id         = var.cloudflare_zone_id
  name            = "redis"
  value           = fly_ip.this.address
  type            = "A"
  ttl             = 1
  allow_overwrite = true
  proxied         = false
}
