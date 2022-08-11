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
