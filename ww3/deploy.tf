module "aws-oidc-deploy" {
  source = "../module/aws-oidc-deploy"
  name   = "ww3-api"
  resource_access_policy = {
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
  }
  allowed_repos = ["isitww3yet-api"]
}
