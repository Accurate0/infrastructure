resource "cloudflare_record" "api" {
  zone_id = var.cloudflare_perthtransport_zone_id
  name    = "api"
  value   = fly_ip.api.address
  type    = "A"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "cert-validation" {
  zone_id = var.cloudflare_perthtransport_zone_id
  name    = fly_cert.api.dnsvalidationhostname
  value   = fly_cert.api.dnsvalidationtarget
  type    = "CNAME"
  ttl     = 1
  proxied = false
}
