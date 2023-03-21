resource "aws_apigatewayv2_domain_name" "this" {
  domain_name = "aws-api.anurag.sh"

  domain_name_configuration {
    certificate_arn = aws_acm_certificate.cert-api.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

data "aws_apigatewayv2_api" "maccas-api" {
  api_id = "ui2bdyh9d2"
}

resource "aws_apigatewayv2_api_mapping" "maccas-api" {
  api_id          = data.aws_apigatewayv2_api.maccas-api.id
  domain_name     = aws_apigatewayv2_domain_name.this.id
  stage           = "v1"
  api_mapping_key = "maccas/v1"
}
