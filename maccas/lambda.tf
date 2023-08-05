resource "aws_iam_role" "iam" {
  name = "iam_for_MaccasApi"

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

resource "aws_iam_policy" "resource-access" {
  name = "maccas-api-resource-access"
  policy = jsonencode({
    "Version" = "2012-10-17"

    "Statement" = [{
      "Sid"    = "ListAndDescribe"
      "Effect" = "Allow"
      "Action" = [
        "dynamodb:List*",
        "dynamodb:DescribeReservedCapacity*",
        "dynamodb:DescribeLimits",
        "dynamodb:DescribeTimeToLive"
      ]
      "Resource" = "*"
      },
      {
        "Sid"    = "SpecificTable"
        "Effect" = "Allow"
        "Action" = [
          "dynamodb:BatchGet*",
          "dynamodb:DescribeStream",
          "dynamodb:DescribeTable",
          "dynamodb:Get*",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:BatchWrite*",
          "dynamodb:CreateTable",
          "dynamodb:Delete*",
          "dynamodb:Update*",
          "dynamodb:PutItem"
        ]
        "Resource" = [
          "arn:aws:dynamodb:*:*:table/MaccasApi-*",
          "arn:aws:dynamodb:*:*:table/MaccasApi-*/index/*",
        ]
      },
      {
        "Effect" = "Allow"
        "Action" = [
          "s3:GetObject",
        ]
        "Resource" = ["${aws_s3_bucket.config.arn}", "${aws_s3_bucket.config.arn}/*"]
      },
      {
        "Effect" = "Allow"
        "Action" = [
          "s3:PutObject",
          "s3:ListBucket",
          "s3:GetObject",
        ]
        "Resource" = ["${aws_s3_bucket.image-bucket.arn}", "${aws_s3_bucket.image-bucket.arn}/*"]
      },
      {
        "Effect" = "Allow"
        "Action" = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl"
        ],
        "Resource" = [
          "${aws_sqs_queue.maccas-cleanup-queue.arn}",
          "${aws_sqs_queue.maccas-images-queue.arn}",
          "${aws_sqs_queue.maccas-refresh-failure-queue.arn}",
          "${aws_sqs_queue.maccas-accounts-queue.arn}",
        ]
      },
      {
        "Effect" = "Allow",
        "Action" = [
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds"
        ],
        "Resource" = [
          "${aws_secretsmanager_secret.api-secret-ad-client.arn}",
          "${aws_secretsmanager_secret.api-secret-places-api-key.arn}",
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

resource "aws_iam_role_policy_attachment" "resource-full-access-attachment" {
  role       = aws_iam_role.iam.name
  policy_arn = aws_iam_policy.resource-access.arn
}

resource "aws_iam_role_policy_attachment" "lambda-basic-execution" {
  role       = aws_iam_role.iam.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "archive_file" "dummy" {
  type        = "zip"
  output_path = "${path.module}/lambda_function_payload.zip"

  source {
    content  = "dummy"
    filename = "dummy.txt"
  }
}

resource "aws_lambda_function" "api" {
  function_name = "MaccasApi-api"
  handler       = "bootstrap"
  role          = aws_iam_role.iam.arn
  filename      = data.archive_file.dummy.output_path
  timeout       = 30
  memory_size   = 256
  runtime       = "provided.al2"
  layers        = ["arn:aws:lambda:ap-southeast-2:753240598075:layer:LambdaAdapterLayerX86:16"]
  environment {
    variables = {
      "AWS_LAMBDA_EXEC_WRAPPER"      = "/opt/bootstrap"
      "RUST_LOG"                     = "info"
      "AWS_LWA_PORT"                 = "8000"
      "PORT"                         = "8000"
      "AWS_LWA_READINESS_CHECK_PATH" = "/health/status"
      "AWS_LWA_ENABLE_COMPRESSION"   = "true"
    }
  }
}

resource "aws_lambda_function" "cleanup" {
  function_name = "MaccasApi-cleanup"
  handler       = "bootstrap"
  role          = aws_iam_role.iam.arn
  filename      = data.archive_file.dummy.output_path
  timeout       = 15
  memory_size   = 128
  runtime       = "provided.al2"
}

resource "aws_lambda_function" "images" {
  function_name = "MaccasApi-images"
  handler       = "bootstrap"
  role          = aws_iam_role.iam.arn
  filename      = data.archive_file.dummy.output_path
  timeout       = 15
  memory_size   = 128
  runtime       = "provided.al2"
}

resource "aws_lambda_function" "refresh-failure" {
  function_name = "MaccasApi-refresh-failure"
  handler       = "bootstrap"
  role          = aws_iam_role.iam.arn
  filename      = data.archive_file.dummy.output_path
  timeout       = 120
  memory_size   = 128
  runtime       = "provided.al2"
}

resource "aws_lambda_function" "accounts" {
  function_name = "MaccasApi-accounts"
  handler       = "bootstrap"
  role          = aws_iam_role.iam.arn
  filename      = data.archive_file.dummy.output_path
  timeout       = 300
  memory_size   = 128
  runtime       = "provided.al2"
}
