data "aws_iam_policy_document" "ecs-agent" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs-agent" {
  name               = "default-ecs-agent"
  assume_role_policy = data.aws_iam_policy_document.ecs-agent.json
}

resource "aws_iam_role_policy_attachment" "ecs-agent" {
  role       = aws_iam_role.ecs-agent.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs-agent" {
  name = "default-ecs-agent"
  role = aws_iam_role.ecs-agent.name
}
