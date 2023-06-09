resource "aws_iam_role" "iam_for_weather_service" {
  name = "iam_for_weather_service"

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

resource "aws_iam_role_policy_attachment" "lambda-basic-execution" {
  role       = aws_iam_role.iam_for_weather_service.name
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

resource "aws_lambda_function" "weather-service" {
  function_name = "WeatherService"
  role          = aws_iam_role.iam_for_weather_service.arn
  handler       = "WeatherService::WeatherService.WeatherService::Run"
  filename      = data.archive_file.dummy.output_path
  timeout       = 30
  memory_size   = 256
  environment {
    variables = {
      cosmosdb_connection_string = sensitive(module.cosmodb-connection-string.secret_value)
    }
  }

  runtime = "dotnet6"
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

resource "aws_cloudwatch_event_target" "weather-invoke-target" {
  rule = aws_cloudwatch_event_rule.weather-every-30-minutes.name
  arn  = aws_lambda_function.weather-service.arn
}
