resource "azurerm_static_site" "maccas-web" {
  name                = "Maccas-Web"
  resource_group_name = azurerm_resource_group.maccas-api.name
  location            = "eastasia"
}

resource "azurerm_static_site_custom_domain" "maccas-web-domain" {
  static_site_id  = azurerm_static_site.maccas-web.id
  domain_name     = "maccas.anurag.sh"
  validation_type = "dns-txt-token"
}

resource "cloudflare_record" "maccas" {
  zone_id         = var.cloudflare_zone_id
  name            = "maccas"
  value           = azurerm_static_site.maccas-web.default_host_name
  type            = "CNAME"
  proxied         = false
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "maccas-txt" {
  zone_id         = var.cloudflare_zone_id
  name            = "maccas"
  value           = azurerm_static_site_custom_domain.maccas-web-domain.validation_token
  type            = "TXT"
  proxied         = false
  ttl             = 1
  allow_overwrite = true
}

variable "cloudflare_zone_id" {
  type      = string
  sensitive = true
}
