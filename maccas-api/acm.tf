resource "aws_acm_certificate" "cert" {
  domain_name       = "i.maccas.anurag.sh"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
  provider = aws.us-east-1
}
