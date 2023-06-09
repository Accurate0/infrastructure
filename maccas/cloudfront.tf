locals {
  s3_origin_id         = "image-bucket"
  one_month_in_seconds = 2592000
  one_week_in_seconds  = 604800
}

resource "aws_cloudfront_origin_access_control" "images" {
  name                              = "maccas-images-policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_cache_policy" "maccas-image-cache" {
  name        = "maccas-image-cache-policy"
  default_ttl = local.one_month_in_seconds
  max_ttl     = local.one_month_in_seconds
  min_ttl     = local.one_month_in_seconds
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

resource "aws_cloudfront_response_headers_policy" "maccas-image-response-headers" {
  name = "maccas-image-response-header-policy"

  custom_headers_config {
    items {
      header   = "Cache-Control"
      value    = "max-age=${local.one_week_in_seconds}"
      override = true
    }
  }
}

resource "aws_cloudfront_distribution" "image-s3-distribution-maccas-one" {
  origin {
    domain_name              = aws_s3_bucket.image-bucket.bucket_regional_domain_name
    origin_id                = local.s3_origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.images.id
  }

  enabled         = true
  is_ipv6_enabled = true
  aliases         = ["i.maccas.one"]
  http_version    = "http2and3"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    viewer_protocol_policy     = "redirect-to-https"
    cache_policy_id            = aws_cloudfront_cache_policy.maccas-image-cache.id
    response_headers_policy_id = aws_cloudfront_response_headers_policy.maccas-image-response-headers.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.cert-maccas-one.arn
    ssl_support_method  = "sni-only"
  }
}
