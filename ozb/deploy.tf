module "aws-oidc-deploy" {
  source = "../module/aws-oidc-deploy"
  name   = "ozb"
  resource_access_policy = {
    "Version" = "2012-10-17"

    "Statement" = [
      {
        "Action" : [
          "lambda:UpdateFunctionCode",
        ],
        "Effect" : "Allow",
        "Resource" : [
          "${aws_lambda_function.daemon.arn}",
          "${aws_lambda_function.trigger.arn}",
          "${aws_lambda_function.timed.arn}",
        ]
      },
    ]
  }
  allowed_repos = ["ozb"]
}
