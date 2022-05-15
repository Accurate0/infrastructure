resource "aws_lambda_function" "api-refresh-singapore" {
  provider      = aws.singapore
  function_name = "MaccasApi-refresh-v2"
  handler       = "bootstrap"
  role          = aws_iam_role.iam.arn
  filename      = data.archive_file.dummy.output_path
  timeout       = 60
  memory_size   = 256
  runtime       = "provided.al2"
  environment {
    variables = {
      MACCAS_REFRESH_REGION = "singapore"
    }
  }
}
