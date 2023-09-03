data "aws_s3_bucket" "tf-state" {
  bucket = "shared-tf-state"
}

data "aws_dynamodb_table" "tf-state-lock" {
  name = "shared-tf-state-lock"
}

module "aws-oidc-deploy" {
  source = "../module/aws-oidc-deploy"
  name   = "maccas-api"
  resource_access_policy = {
    "Version" = "2012-10-17"

    "Statement" = [
      {
        "Effect" = "Allow",
        "Action" = [
          "lambda:UpdateFunctionCode",
        ],
        "Resource" = [
          "${aws_lambda_function.api.arn}",
          "${aws_lambda_function.cleanup.arn}",
          "${aws_lambda_function.images.arn}",
          "${aws_lambda_function.refresh-failure.arn}",
          "${aws_lambda_function.accounts.arn}",
          "${aws_lambda_function.api-dev.arn}",
          "${module.refresh-syd.lambda_arn}",
          "${module.refresh-mel.lambda_arn}",
          "${module.refresh-sng.lambda_arn}",
        ]
      },
      {
        "Effect" = "Allow",
        "Action" = [
          "s3:PutObject",
        ],
        "Resource" = [
          "${aws_s3_bucket.config.arn}/*",
        ]
      },

      {
        "Effect" = "Allow",
        "Action" = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
        ],
        "Resource" = [
          "${data.aws_s3_bucket.tf-state.arn}/maccas/*",
        ]
      },
      {
        "Effect" = "Allow",
        "Action" = [
          "s3:ListBucket",
        ],
        "Resource" = [
          "${data.aws_s3_bucket.tf-state.arn}",
        ]
      },
      {
        "Effect" = "Allow",
        "Action" = [
          "dynamodb:DescribeTable",
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem"
        ],
        "Resource" = [
          "${data.aws_dynamodb_table.tf-state-lock.arn}",
        ]
      },
      {
        "Effect" = "Allow",
        "Action" = [
          "apigateway:POST",
        ],
        "Resource" = [
          "${aws_apigatewayv2_api.this.arn}/authorizers",
          "${aws_apigatewayv2_api.this-dev.arn}/authorizers",
          "${aws_apigatewayv2_api.this.arn}/routes",
          "${aws_apigatewayv2_api.this-dev.arn}/routes",
        ]
      },
      {
        "Effect" = "Allow",
        "Action" = [
          "apigateway:GET",
        ],
        "Resource" = [
          "*",
        ]
      }
    ]
  }
  allowed_repos = ["maccas-api"]
}
