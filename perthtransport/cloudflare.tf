resource "cloudflare_record" "api" {
  zone_id = var.cloudflare_perthtransport_zone_id
  name    = "api"
  value   = "oracle.anurag.sh"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "perthtransport" {
  zone_id         = var.cloudflare_perthtransport_zone_id
  name            = "@"
  value           = "oracle.anurag.sh"
  type            = "CNAME"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "www-perthtransport" {
  zone_id         = var.cloudflare_perthtransport_zone_id
  name            = "www"
  value           = "perthtransport.xyz"
  type            = "CNAME"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_ruleset" "api-perthtransport" {
  zone_id = var.cloudflare_perthtransport_zone_id
  name    = "API Backend"
  kind    = "zone"
  phase   = "http_config_settings"

  rules {
    action = "set_config"
    action_parameters {
      ssl = "full"
    }
    expression  = "(http.request.full_uri contains \"api.perthtransport.xyz\")"
    description = "API Backend Flexible"
    enabled     = true
  }
}
