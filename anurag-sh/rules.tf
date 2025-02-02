resource "cloudflare_page_rule" "new-maccas-redirect" {
  zone_id  = var.cloudflare_zone_id
  target   = "maccas.anurag.sh/*"
  priority = 1

  actions = {
    forwarding_url = {
      url         = "https://maccas.one"
      status_code = 301
    }
  }
}
