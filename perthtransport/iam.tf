resource "aws_iam_role" "ecs-task-execution-role" {
  name               = "perthtransport-ecs-task-execution-role"
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
  name               = "perthtransport-ecs-container-iam-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs-container-resource-access" {
  role       = aws_iam_role.ecs-container-iam-role.name
  policy_arn = aws_iam_policy.resource-access.arn
}

resource "aws_iam_policy" "resource-access" {
  name = "perthtransport-resource-access"
  policy = jsonencode({
    "Version" = "2012-10-17"

    "Statement" = [{
      // need to allow listing all secerets to do the prefix search
      "Effect" = "Allow",
      "Action" = [
        "secretsmanager:ListSecrets"
      ],
      "Resource" = [
        "*"
      ]
    }]
  })
}
