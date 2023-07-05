module "aws-oidc-deploy" {
  source              = "../module/aws-oidc-deploy"
  name                = "assets"
  resource_access_policy = {
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
  }
  allowed_repos       = ["resume"]
}
