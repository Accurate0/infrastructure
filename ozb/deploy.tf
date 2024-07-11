module "aws-oidc-deploy" {
  source = "../module/aws-oidc-deploy"
  name   = "ozb"
  resource_access_policy = {
    "Version" = "2012-10-17"

    "Statement" = [
      {
        "Effect" = "Allow",
        "Action" = [
          "ecr:GetAuthorizationToken",
        ],
        "Resource" = [
          "*",
        ]
      },
      {
        "Action" : [
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:InitiateLayerUpload",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage"
        ],
        "Effect" : "Allow",
        "Resource" : "${aws_ecr_repository.this.arn}"
      },
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

resource "github_actions_variable" "ecr-registry-url" {
  repository    = "ozb"
  variable_name = "AWS_ECR_REGISTRY"
  value         = aws_ecr_repository.this.repository_url
}
