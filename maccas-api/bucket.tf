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
