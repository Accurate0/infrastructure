resource "aws_acm_certificate" "cert-maccas-one" {
  domain_name       = "i.maccas.one"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
  provider = aws.us-east-1
}
