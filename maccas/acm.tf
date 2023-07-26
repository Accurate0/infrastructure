resource "aws_acm_certificate" "cert-maccas-one" {
  domain_name       = "i.maccas.one"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
  provider = aws.us-east-1
}

resource "aws_acm_certificate" "cert-api" {
  domain_name       = "api.maccas.one"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "cert-api-dev" {
  domain_name       = "api.dev.maccas.one"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
