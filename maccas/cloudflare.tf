variable "cloudflare_zone_id_maccas_one" {
  type      = string
  sensitive = true
  default   = "7104890048c02e9a312f6ebbc8a8359a"
}

resource "cloudflare_record" "validation-record-api" {
  for_each = {
    for item in aws_acm_certificate.cert-api.domain_validation_options : item.domain_name => {
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

resource "cloudflare_record" "maccas-one-api" {
  zone_id         = var.cloudflare_zone_id_maccas_one
  allow_overwrite = true
  proxied         = false
  name            = "api"
  type            = "CNAME"
  value           = aws_apigatewayv2_domain_name.this.domain_name_configuration[0].target_domain_name
  ttl             = 1
}

resource "cloudflare_record" "www-maccas-one" {
  zone_id         = var.cloudflare_zone_id_maccas_one
  name            = "www"
  value           = "maccas.one"
  type            = "CNAME"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "old-maccas-one" {
  zone_id         = var.cloudflare_zone_id_maccas_one
  name            = "old"
  value           = "cname.vercel-dns.com"
  type            = "CNAME"
  proxied         = false
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "next-maccas-one" {
  zone_id         = var.cloudflare_zone_id_maccas_one
  name            = "@"
  value           = "maccas-web.fly.dev"
  type            = "CNAME"
  proxied         = false
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "dashboard-next-maccas-one" {
  zone_id         = var.cloudflare_zone_id_maccas_one
  name            = "dashboard"
  value           = "maccas-dashboard.fly.dev"
  type            = "CNAME"
  proxied         = false
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "batch-next-maccas-one" {
  zone_id         = var.cloudflare_zone_id_maccas_one
  name            = "batch"
  value           = "maccas-batch.fly.dev"
  type            = "CNAME"
  proxied         = false
  ttl             = 1
  allow_overwrite = true
}


resource "cloudflare_record" "event-next-maccas-one" {
  zone_id         = var.cloudflare_zone_id_maccas_one
  name            = "event"
  value           = "maccas-event.fly.dev"
  type            = "CNAME"
  proxied         = false
  ttl             = 1
  allow_overwrite = true
}


resource "cloudflare_record" "database-next-maccas-one" {
  zone_id         = var.cloudflare_zone_id_maccas_one
  name            = "database"
  value           = "maccas-db.fly.dev"
  type            = "CNAME"
  proxied         = false
  ttl             = 1
  allow_overwrite = true
}

resource "cloudflare_record" "aws-wild" {
  zone_id = var.cloudflare_zone_id_maccas_one
  name    = "@"
  data {
    flags = "0"
    tag   = "issuewild"
    value = "awstrust.com"
  }
  type            = "CAA"
  ttl             = 1
  allow_overwrite = true
}
