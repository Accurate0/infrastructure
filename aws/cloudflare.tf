resource "cloudflare_record" "validation-record-api" {
  for_each = {
    for item in aws_acm_certificate.cert-api.domain_validation_options : item.domain_name => {
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

resource "cloudflare_record" "aws-api" {
  zone_id         = var.cloudflare_zone_id
  allow_overwrite = true
  proxied         = false
  name            = "aws-api"
  type            = "CNAME"
  value           = aws_apigatewayv2_domain_name.this.domain_name_configuration[0].target_domain_name
  ttl             = 1
}
