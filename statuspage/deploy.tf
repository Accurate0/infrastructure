module "aws-oidc-deploy" {
  source = "../module/aws-oidc-deploy"
  name   = "statuspage"
  resource_access_policy = {
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
  }
  allowed_repos = ["statuspage"]
}
