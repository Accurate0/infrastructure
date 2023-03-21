resource "aws_acm_certificate" "cert-api" {
  domain_name       = "aws-api.anurag.sh"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
