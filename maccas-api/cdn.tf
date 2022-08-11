resource "aws_cloudfront_origin_access_identity" "image-bucket" {
}

data "aws_iam_policy_document" "image-bucket-s3-policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.image-bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.image-bucket.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "image-bucket" {
  bucket = aws_s3_bucket.image-bucket.id
  policy = data.aws_iam_policy_document.image-bucket-s3-policy.json
}

locals {
  s3_origin_id = "image-bucket"
}

resource "aws_cloudfront_distribution" "image-s3-distribution" {
  origin {
    domain_name = aws_s3_bucket.image-bucket.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.image-bucket.cloudfront_access_identity_path
    }
  }

  enabled         = true
  is_ipv6_enabled = true
  aliases         = ["i.maccas.anurag.sh"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 604800
    default_ttl            = 604800
    max_ttl                = 604800
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
}
