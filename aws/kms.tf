resource "aws_kms_key" "ssmkey" {
  description         = "Session Manager Key"
  enable_key_rotation = true
}
