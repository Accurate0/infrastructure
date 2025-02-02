resource "cloudflare_dns_record" "maccas" {
  zone_id = var.cloudflare_zone_id
  name    = "maccas"
  content = "anurag.sh"
  type    = "CNAME"
  proxied = true
  ttl     = 1
}

