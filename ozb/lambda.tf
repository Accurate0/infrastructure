data "archive_file" "dummy" {
  type        = "zip"
  output_path = "${path.module}/lambda_function_payload.zip"

  source {
    content  = "dummy"
    filename = "dummy.txt"
  }
}

resource "aws_lambda_function" "trigger" {
  function_name = "Ozb-Trigger"
  handler       = "bootstrap"
  role          = aws_iam_role.iam.arn
  filename      = data.archive_file.dummy.output_path
  timeout       = 300
  memory_size   = 128
  runtime       = "provided.al2"

  environment {
    variables = {
      AXIOM_TOKEN   = module.axiom-token.secret_value
      AXIOM_DATASET = "main"
    }
  }
}

resource "aws_lambda_function" "timed" {
  function_name = "Ozb-Timed"
  handler       = "bootstrap"
  role          = aws_iam_role.iam.arn
  filename      = data.archive_file.dummy.output_path
  timeout       = 300
  memory_size   = 128
  runtime       = "provided.al2"

  environment {
    variables = {
      AXIOM_TOKEN   = module.axiom-token.secret_value
      AXIOM_DATASET = "main"
    }
  }
}

resource "aws_lambda_function" "daemon" {
  function_name = "Ozb-Daemon"
  handler       = "bootstrap"
  role          = aws_iam_role.iam.arn
  filename      = data.archive_file.dummy.output_path
  timeout       = 300
  memory_size   = 128
  runtime       = "provided.al2"

  environment {
    variables = {
      AXIOM_TOKEN   = module.axiom-token.secret_value
      AXIOM_DATASET = "main"
    }
  }
}
