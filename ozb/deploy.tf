module "aws-oidc-deploy" {
  source              = "../module/aws-oidc-deploy"
  name                = "ozb"
  resource_access_arn = aws_iam_policy.deploy-resource-access.arn
  allowed_repos       = ["ozb"]
}

resource "aws_iam_policy" "deploy-resource-access" {
  name = "ozb-deploy-resource-access"
  policy = jsonencode({
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
          "ecs:UpdateService",
        ],
        "Effect" : "Allow",
        "Resource" : "${aws_ecs_service.this.id}"
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
  })
}

resource "github_actions_variable" "ecr-registry-url" {
  repository    = "ozb"
  variable_name = "AWS_ECR_REGISTRY"
  value         = aws_ecr_repository.this.repository_url
}
