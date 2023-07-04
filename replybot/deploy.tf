module "aws-oidc-deploy" {
  source = "../module/aws-oidc-deploy"
  name   = "replybot"
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
          "ecs:UpdateService",
        ],
        "Effect" : "Allow",
        "Resource" : "${aws_ecs_service.this.id}"
      },
    ]
  }
  allowed_repos = ["replybot"]
}

resource "github_actions_variable" "ecr-registry-url" {
  repository    = "replybot"
  variable_name = "AWS_ECR_REGISTRY"
  value         = aws_ecr_repository.this.repository_url
}
