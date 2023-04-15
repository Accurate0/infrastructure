module "aws-oidc-deploy" {
  source              = "../module/aws-oidc-deploy"
  name                = "assets"
  resource_access_arn = aws_iam_policy.deploy-resource-access.arn
  allowed_repos       = ["resume"]
}

resource "aws_iam_policy" "deploy-resource-access" {
  name = "assets-deploy-resource-access"
  policy = jsonencode({
    "Version" = "2012-10-17"

    "Statement" = [
      {
        "Effect" = "Allow",
        "Action" = [
          "s3:PutObject",
        ],
        "Resource" = [
          "${aws_s3_bucket.assets-bucket.arn}/*",
        ]
      }
    ]
  })
}
