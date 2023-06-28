module "aws-oidc-deploy" {
  source              = "../module/aws-oidc-deploy"
  name                = "statuspage"
  resource_access_arn = aws_iam_policy.deploy-resource-access.arn
  allowed_repos       = ["statuspage"]
}

resource "aws_iam_policy" "deploy-resource-access" {
  name = "statuspage-deploy-resource-access"
  policy = jsonencode({
    "Version" = "2012-10-17"

    "Statement" = [
      {
        "Effect" = "Allow",
        "Action" = [
          "lambda:UpdateFunctionCode",
        ],
        "Resource" = [
          "${aws_lambda_function.healthcheck.arn}",
        ]
      },
    ]
  })
}
