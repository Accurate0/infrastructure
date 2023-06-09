module "aws-oidc-deploy" {
  source              = "../module/aws-oidc-deploy"
  name                = "maccas-api"
  resource_access_arn = aws_iam_policy.deploy-resource-access.arn
  allowed_repos       = ["maccas-api"]
}

resource "aws_iam_policy" "deploy-resource-access" {
  name = "maccas-api-deploy-resource-access"
  policy = jsonencode({
    "Version" = "2012-10-17"

    "Statement" = [
      {
        "Effect" = "Allow",
        "Action" = [
          "lambda:UpdateFunctionCode",
        ],
        "Resource" = [
          "${aws_lambda_function.api.arn}",
          "${aws_lambda_function.cleanup.arn}",
          "${aws_lambda_function.images.arn}",
          "${aws_lambda_function.refresh-failure.arn}",
          "${aws_lambda_function.accounts.arn}",
          "${aws_lambda_function.api-dev.arn}",
          "${module.refresh-syd.lambda_arn}",
          "${module.refresh-mel.lambda_arn}",
          "${module.refresh-sng.lambda_arn}",
        ]
      },
      {
        "Effect" = "Allow",
        "Action" = [
          "s3:PutObject",
        ],
        "Resource" = [
          "${aws_s3_bucket.config.arn}/*",
        ]
      }
    ]
  })
}
