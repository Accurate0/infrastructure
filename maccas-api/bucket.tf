resource "aws_s3_bucket" "config" {
  bucket = "maccas-application-config"
}

resource "aws_s3_bucket_acl" "config-acl" {
  bucket = aws_s3_bucket.config.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "config-public-block" {
  bucket = aws_s3_bucket.config.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "image-bucket" {
  bucket = "maccas-image-bucket"
}

resource "aws_s3_bucket_acl" "image-bucket-acl" {
  bucket = aws_s3_bucket.image-bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "image-bucket-public-block" {
  bucket = aws_s3_bucket.image-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

data "aws_iam_policy_document" "image-bucket-s3-policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.image-bucket.arn}/*"]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"

      values = [aws_cloudfront_distribution.image-s3-distribution.arn]
    }

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
  }
}

resource "aws_s3_bucket_policy" "image-bucket" {
  bucket = aws_s3_bucket.image-bucket.id
  policy = data.aws_iam_policy_document.image-bucket-s3-policy.json
}
