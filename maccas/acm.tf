resource "aws_acm_certificate" "cert-api" {
  domain_name       = "api.maccas.one"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

