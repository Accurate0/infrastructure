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
          "elasticfilesystem:*",
          "kms:*",
          "sns:*",
          "route53:*",
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}

# ECS anywhere
resource "aws_iam_role" "iam-ecs-anywhere" {
  name = "iam_for_ECS_Anywhere"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = {
      "Effect" : "Allow",
      "Principal" : { "Service" : [
        "ssm.amazonaws.com"
      ] },
      "Action" : "sts:AssumeRole"
    }
  })
}

resource "aws_iam_role_policy_attachment" "iam-ssm-core" {
  role       = aws_iam_role.iam-ecs-anywhere.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ec2-service-role" {
  role       = aws_iam_role.iam-ecs-anywhere.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
