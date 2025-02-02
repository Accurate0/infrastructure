resource "cloudflare_dns_record" "www-perthtransport" {
  zone_id         = var.cloudflare_perthtransport_zone_id
  name            = "www"
  content         = "perthtransport.xyz"
  type            = "CNAME"
  proxied         = true
  ttl             = 1
}
#
# resource "cloudflare_ruleset" "api-perthtransport" {
#   zone_id = var.cloudflare_perthtransport_zone_id
#   name    = "API Backend"
#   kind    = "zone"
#   phase   = "http_config_settings"
#
#   rules = [{
#     action = "set_config"
#     action_parameters = {
#       ssl = "full"
#     }
#     expression  = "(http.request.full_uri contains \"api.perthtransport.xyz\")"
#     description = "API Backend Flexible"
#     enabled     = true
#   }]
# }
