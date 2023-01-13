resource "cloudflare_record" "api" {
  zone_id         = var.cloudflare_zone_id
  name            = "api"
  value           = trimprefix(azurerm_api_management.general-apim.gateway_url, "https://")
  type            = "CNAME"
  ttl             = 1
  allow_overwrite = true
}
