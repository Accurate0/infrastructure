resource "aws_acm_certificate" "cert" {
  domain_name       = "assets.anurag.sh"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
  provider = aws.us-east-1
}

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

resource "cloudflare_record" "assets" {
  zone_id         = var.cloudflare_zone_id
  allow_overwrite = true
  proxied         = false
  name            = "assets"
  type            = "CNAME"
  value           = aws_cloudfront_distribution.assets-s3-distribution.domain_name
  ttl             = 1
}

data "aws_iam_policy_document" "assets-bucket-s3-policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.assets-bucket.arn}/*"]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"

      values = [aws_cloudfront_distribution.assets-s3-distribution.arn]
    }

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
  }
}

resource "aws_cloudfront_origin_access_control" "assets" {
  name                              = "anurag-sh-assets-policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_s3_bucket_policy" "assets-bucket" {
  bucket = aws_s3_bucket.assets-bucket.id
  policy = data.aws_iam_policy_document.assets-bucket-s3-policy.json
}

locals {
  s3_origin_id        = "assets-bucket"
  one_hour_in_seconds = 3600
}

resource "aws_cloudfront_cache_policy" "assets-cache-policy" {
  name        = "anurag-sh-assets-cache-policy"
  default_ttl = local.one_hour_in_seconds
  max_ttl     = local.one_hour_in_seconds
  min_ttl     = local.one_hour_in_seconds
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }

    enable_accept_encoding_brotli = true
    enable_accept_encoding_gzip   = true
  }
}

resource "aws_cloudfront_response_headers_policy" "assets-response-headers" {
  name = "anurag-sh-assets-response-header-policy"

  custom_headers_config {
    items {
      header   = "Cache-Control"
      value    = "max-age=${local.one_hour_in_seconds}"
      override = true
    }
  }
}

resource "aws_cloudfront_distribution" "assets-s3-distribution" {
  origin {
    domain_name              = aws_s3_bucket.assets-bucket.bucket_regional_domain_name
    origin_id                = local.s3_origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.assets.id
  }

  enabled         = true
  is_ipv6_enabled = true
  aliases         = ["assets.anurag.sh"]
  http_version    = "http2and3"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    viewer_protocol_policy     = "redirect-to-https"
    cache_policy_id            = aws_cloudfront_cache_policy.assets-cache-policy.id
    response_headers_policy_id = aws_cloudfront_response_headers_policy.assets-response-headers.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.cert.arn
    ssl_support_method  = "sni-only"
  }
  custom_error_response {
    error_code         = 403
    response_code      = 404
    response_page_path = "/404.html"
  }
}

resource "aws_s3_bucket" "assets-bucket" {
  bucket = "anurag-sh-assets-bucket"
}

resource "aws_s3_bucket_acl" "assets-bucket-acl" {
  bucket = aws_s3_bucket.assets-bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "assets-bucket-public-block" {
  bucket = aws_s3_bucket.assets-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_object" "not-found-page" {
  bucket = aws_s3_bucket.assets-bucket.id
  key    = "404.html"
  source = "resources/404.html"
  etag   = filemd5("resources/404.html")
}
