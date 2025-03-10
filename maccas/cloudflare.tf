variable "cloudflare_zone_id_maccas_one" {
  type      = string
  sensitive = true
  default   = "7104890048c02e9a312f6ebbc8a8359a"
}

resource "cloudflare_dns_record" "validation-record-api" {
  for_each = {
    for item in aws_acm_certificate.cert-api.domain_validation_options : item.domain_name => {
      name   = item.resource_record_name
      record = item.resource_record_value
      type   = item.resource_record_type
    }
  }

  zone_id = var.cloudflare_zone_id_maccas_one
  proxied = false
  name    = each.value.name
  type    = each.value.type
  content = each.value.record
  ttl     = 1

  lifecycle {
    ignore_changes = [content]
  }
}

resource "cloudflare_dns_record" "maccas-one-api" {
  zone_id = var.cloudflare_zone_id_maccas_one
  proxied = false
  name    = "api"
  type    = "CNAME"
  content = aws_apigatewayv2_domain_name.this.domain_name_configuration[0].target_domain_name
  ttl     = 1
}

resource "cloudflare_dns_record" "www-maccas-one" {
  zone_id = var.cloudflare_zone_id_maccas_one
  name    = "www"
  content = "maccas.one"
  type    = "CNAME"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "aws-wild" {
  zone_id = var.cloudflare_zone_id_maccas_one
  name    = "@"
  data = {
    flags = 0
    tag   = "issuewild"
    value = "awstrust.com"
  }
  type = "CAA"
  ttl  = 1
}


resource "cloudflare_dns_record" "aws-api-issue" {
  zone_id = var.cloudflare_zone_id_maccas_one
  name    = "api"
  data = {
    flags = 0
    tag   = "issue"
    value = "awstrust.com"
  }
  type = "CAA"
  ttl  = 1
}
#
# resource "cloudflare_ruleset" "ssl" {
#   zone_id = var.cloudflare_zone_id_maccas_one
#   name    = "Maccas SSL"
#   kind    = "zone"
#   phase   = "http_config_settings"
#
#   rules = [{
#     action = "set_config"
#     action_parameters = {
#       ssl = "full"
#     }
#     expression = <<EOF
#             (http.host eq "batch.maccas.one")
#          or (http.host eq "dashboard.maccas.one")
#          or (http.host eq "graphql.maccas.one")
#          or (http.host eq "maccas.one")
#          or (http.host eq "event.maccas.one")
# EOF
#
#     description = "Maccas Full SSL"
#     enabled     = true
#   }]
# }
