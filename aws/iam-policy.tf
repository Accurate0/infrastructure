resource "aws_iam_group_policy" "terraform-main-group-policy" {
  name  = "terraform-main-group-policy"
  group = aws_iam_group.terraform-main.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Action" : [
          "ec2:*",
          "ecs:*",
          "ecr:*",
          "ssm:*",
          "appconfig:*",
          "secretsmanager:*",
          "iam:*",
          "acm:*",
          "cloudfront:*",
          "lambda:*",
          "sqs:*",
          "s3:*",
          "cloudwatch:*",
          "dynamodb:*",
          "logs:*",
          "organizations:*",
          "events:*",
          "apigateway:*",
          "scheduler:*",
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_group_policy" "actions-main-group-policy" {
  name  = "actions-main-group-policy"
  group = aws_iam_group.actions-main.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Action" : [
          "lambda:*",
          "s3:*",
          "ec2:*",
          "ecr:*",
          "ecs:*",
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}
