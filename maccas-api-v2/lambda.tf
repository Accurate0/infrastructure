resource "aws_iam_role" "iam" {
  name = "iam_for_MaccasApi-v2"

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
  name = "maccas-api-resource-access-v2"
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
          "arn:aws:dynamodb:*:*:table/${aws_dynamodb_table.maccas-api-cache-db.id}",
          "arn:aws:dynamodb:*:*:table/${data.aws_dynamodb_table.maccas-api-db-v1.id}",
          "arn:aws:dynamodb:*:*:table/${aws_dynamodb_table.maccas-api-user-config-db.id}",
          "arn:aws:dynamodb:*:*:table/${data.aws_dynamodb_table.maccas-api-cache-db-v1.id}",
          "arn:aws:dynamodb:*:*:table/${data.aws_dynamodb_table.maccas-api-offer-id-db-v1.id}",
        ]
      },
      {
        "Effect" = "Allow"
        "Action" = [
          "s3:GetObject",
        ]
        "Resource" = ["${aws_s3_bucket.config.arn}", "${aws_s3_bucket.config.arn}/*"]
    }]
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
  function_name = "MaccasApi-v2"
  handler       = "bootstrap"
  role          = aws_iam_role.iam.arn
  filename      = data.archive_file.dummy.output_path
  timeout       = 30
  memory_size   = 256
  runtime       = "provided.al2"
}
