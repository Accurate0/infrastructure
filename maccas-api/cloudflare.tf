resource "cloudflare_record" "validation-record" {
  for_each = {
    for item in aws_acm_certificate.cert.domain_validation_options : item.domain_name => {
      name   = item.resource_record_name
      record = item.resource_record_value
      type   = item.resource_record_type
    }
  }

  zone_id         = var.cloudflare_zone_id
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

resource "cloudflare_record" "i-maccas" {
  zone_id         = var.cloudflare_zone_id
  allow_overwrite = true
  proxied         = false
  name            = "i.maccas"
  type            = "CNAME"
  value           = aws_cloudfront_distribution.image-s3-distribution.domain_name
  ttl             = 1
}
