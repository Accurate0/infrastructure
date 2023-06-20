module "aws-oidc-deploy" {
  source              = "../module/aws-oidc-deploy"
  name                = "perthtransport"
  resource_access_arn = aws_iam_policy.deploy-resource-access.arn
  allowed_repos       = ["perth-transport-map"]
}

resource "aws_iam_policy" "deploy-resource-access" {
  name = "perthtransport-deploy-resource-access"
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
        "Resource" : ["${aws_ecr_repository.perthtransport-api.arn}", "${aws_ecr_repository.perthtransport-worker.arn}"]
      },
      {
        "Action" : [
          "ecs:UpdateService",
        ],
        "Effect" : "Allow",
        "Resource" : "${aws_ecs_service.this.id}"
      },
    ]
  })
}

resource "github_actions_variable" "ecr-registry-api-url" {
  repository    = "perth-transport-map"
  variable_name = "AWS_ECR_API_REGISTRY"
  value         = aws_ecr_repository.perthtransport-api.repository_url
}

resource "github_actions_variable" "ecr-registry-worker-url" {
  repository    = "perth-transport-map"
  variable_name = "AWS_ECR_WORKER_REGISTRY"
  value         = aws_ecr_repository.perthtransport-worker.repository_url
}
