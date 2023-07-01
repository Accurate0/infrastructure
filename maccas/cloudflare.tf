resource "cloudflare_record" "validation-record-maccas-one" {
  for_each = {
    for item in aws_acm_certificate.cert-maccas-one.domain_validation_options : item.domain_name => {
      name   = item.resource_record_name
      record = item.resource_record_value
      type   = item.resource_record_type
    }
  }

  zone_id         = var.cloudflare_zone_id_maccas_one
  allow_overwrite = true
  proxied         = false
  name            = each.value.name
  type            = each.value.type
  value           = each.value.record
  ttl             = 1

  lifecycle {
    ignore_changes = [value]
  }
}

resource "cloudflare_record" "i-maccas-one" {
  zone_id         = var.cloudflare_zone_id_maccas_one
  allow_overwrite = true
  proxied         = false
  name            = "i"
  type            = "CNAME"
  value           = aws_cloudfront_distribution.image-s3-distribution-maccas-one.domain_name
  ttl             = 1
}

resource "cloudflare_record" "maccas-one" {
  zone_id         = var.cloudflare_zone_id_maccas_one
  name            = "@"
  value           = "76.76.21.21"
  type            = "A"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "dev-maccas-one" {
  zone_id         = var.cloudflare_zone_id_maccas_one
  name            = "dev"
  value           = "cname.vercel-dns.com"
  type            = "CNAME"
  proxied         = false
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "www-maccas-one" {
  zone_id         = var.cloudflare_zone_id_maccas_one
  name            = "www"
  value           = "maccas.one"
  type            = "CNAME"
  proxied         = false
  ttl             = 1
  allow_overwrite = true
}
