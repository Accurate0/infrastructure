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

resource "aws_iam_policy" "dynamodb-access" {
  name   = "maccas-api-dynamodb-access"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ListAndDescribe",
            "Effect": "Allow",
            "Action": [
                "dynamodb:List*",
                "dynamodb:DescribeReservedCapacity*",
                "dynamodb:DescribeLimits",
                "dynamodb:DescribeTimeToLive"
            ],
            "Resource": "*"
        },
        {
            "Sid": "SpecificTable",
            "Effect": "Allow",
            "Action": [
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
            ],
            "Resource": [
                "arn:aws:dynamodb:*:*:table/${aws_dynamodb_table.maccas-api-db.id}",
                "arn:aws:dynamodb:*:*:table/${aws_dynamodb_table.maccas-api-cache-db.id}",
                "arn:aws:dynamodb:*:*:table/${aws_dynamodb_table.maccas-api-offer-id-db.id}"
            ]

        }
    ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "dynamodb-full-access-attachment" {
  role       = aws_iam_role.iam.name
  policy_arn = aws_iam_policy.dynamodb-access.arn
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
  function_name = "MaccasApi"
  handler       = "bootstrap"
  role          = aws_iam_role.iam.arn
  filename      = data.archive_file.dummy.output_path
  timeout       = 30
  memory_size   = 128
  runtime       = "provided.al2"
}

resource "aws_lambda_function" "api-deals" {
  function_name = "MaccasApi-deals"
  handler       = "bootstrap"
  role          = aws_iam_role.iam.arn
  filename      = data.archive_file.dummy.output_path
  timeout       = 30
  memory_size   = 128
  runtime       = "provided.al2"
}

resource "aws_lambda_function" "api-refresh" {
  function_name = "MaccasApi-refresh"
  handler       = "bootstrap"
  role          = aws_iam_role.iam.arn
  filename      = data.archive_file.dummy.output_path
  timeout       = 120
  memory_size   = 256
  runtime       = "provided.al2"
}

resource "aws_lambda_function_url" "lambda-url" {
  function_name      = aws_lambda_function.api-refresh.function_name
  authorization_type = "NONE"
}
