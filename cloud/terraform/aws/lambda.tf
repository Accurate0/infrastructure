resource "aws_iam_role" "iam_for_weather_service" {
  name = "iam_for_weather_service"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "archive_file" "dummy" {
  type        = "zip"
  output_path = "${path.module}/lambda_function_payload.zip"

  source {
    content  = "dummy"
    filename = "dummy.txt"
  }
}

resource "aws_lambda_function" "weather-service" {
  function_name = "WeatherService"
  role          = aws_iam_role.iam_for_weather_service.arn
  handler       = "index.test"
  filename      = data.archive_file.dummy.output_path

  runtime = "dotnet6"

  environment {
  }
}

resource "aws_cloudwatch_event_rule" "weather-every-30-minutes" {
  name                = "WeatherService30Minutes"
  schedule_expression = "rate(30 minutes)"
}

resource "aws_lambda_permission" "cloudwatch-call-weather-service" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.weather-service.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.weather-every-30-minutes.arn
}