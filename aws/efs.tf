resource "aws_efs_file_system" "data" {
  creation_token = "data"

  tags = {
    Name = "Data"
  }
}

resource "aws_efs_mount_target" "data" {
  file_system_id  = aws_efs_file_system.data.id
  subnet_id       = aws_subnet.internal-subnet-syda.id
  security_groups = [aws_security_group.internal-efs-sg.id]
}

data "aws_iam_policy_document" "efs-policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "elasticfilesystem:ClientRootAccess",
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientWrite",
    ]

    resources = [aws_efs_file_system.data.arn]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["true"]
    }
  }
}

resource "aws_efs_file_system_policy" "efs-policy" {
  file_system_id = aws_efs_file_system.data.id
  policy         = data.aws_iam_policy_document.efs-policy.json
}
