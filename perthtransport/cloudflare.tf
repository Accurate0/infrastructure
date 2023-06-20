resource "cloudflare_record" "api" {
  zone_id = var.cloudflare_perthtransport_zone_id
  name    = "api"
  value   = "oracle.anurag.sh"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "cert-validation" {
  zone_id = var.cloudflare_perthtransport_zone_id
  name    = fly_cert.api.dnsvalidationhostname
  value   = fly_cert.api.dnsvalidationtarget
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "perthtransport" {
  zone_id         = var.cloudflare_perthtransport_zone_id
  name            = "@"
  value           = "76.76.21.21"
  type            = "A"
  proxied         = false
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "www-perthtransport" {
  zone_id         = var.cloudflare_perthtransport_zone_id
  name            = "www"
  value           = "perthtransport.xyz"
  type            = "CNAME"
  proxied         = false
  ttl             = 1
  allow_overwrite = true
}
