module "aws-oidc-deploy" {
  source              = "../module/aws-oidc-deploy"
  name                = "ww3-api"
  resource_access_arn = aws_iam_policy.deploy-resource-access.arn
  allowed_repos       = ["isitww3yet-api"]
}

resource "aws_iam_policy" "deploy-resource-access" {
  name = "ww3-api-deploy-resource-access"
  policy = jsonencode({
    "Version" = "2012-10-17"

    "Statement" = [
      {
        "Effect" = "Allow",
        "Action" = [
          "lambda:UpdateFunctionCode",
          "lambda:PublishVersion",
        ],
        "Resource" = [
          "${module.lambda.lambda_arn}"
        ]
      }
    ]
  })
}
