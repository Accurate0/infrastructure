resource "aws_iam_role" "ecs-task-execution-role" {
  name               = "ozb-ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy" {
  role       = aws_iam_role.ecs-task-execution-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


resource "aws_iam_role" "ecs-container-iam-role" {
  name               = "ozb-ecs-container-iam-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs-container-resource-access" {
  role       = aws_iam_role.ecs-container-iam-role.name
  policy_arn = aws_iam_policy.resource-access.arn
}

resource "aws_iam_policy" "resource-access" {
  name = "ozb-resource-access"
  policy = jsonencode({
    "Version" = "2012-10-17"

    "Statement" = [
      {
        "Effect" = "Allow",
        "Action" = [
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds",
          "secretsmanager:ListSecrets"
        ],
        "Resource" = [
          "${aws_secretsmanager_secret.bot-secret-discord-token.arn}",
          "${aws_secretsmanager_secret.bot-secret-discord-token-dev.arn}",
          "${aws_secretsmanager_secret.mongodb-connection-string.arn}",
          "${aws_secretsmanager_secret.mongodb-connection-string-dev.arn}",
        ]
      },
      {
        // need to allow listing all secerets to do the prefix search
        "Effect" = "Allow",
        "Action" = [
          "secretsmanager:ListSecrets"
        ],
        "Resource" = [
          "*"
        ]
      },
    ]
  })
}

resource "aws_iam_role" "iam" {
  name = "iam-role-for-ozb-trigger"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "resource-full-access-attachment" {
  role       = aws_iam_role.iam.name
  policy_arn = aws_iam_policy.resource-access.arn
}

resource "aws_iam_role_policy_attachment" "lambda-basic-execution" {
  role       = aws_iam_role.iam.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
