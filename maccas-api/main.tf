terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
  }

  cloud {
    organization = "server"
    workspaces {
      name = "maccas-api"
    }
  }
}

provider "aws" {}

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
            "Resource": "arn:aws:dynamodb:*:*:table/${aws_dynamodb_table.maccas-api-db.id}"
        }
    ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "dynamodb-full-access-attachment" {
  role       = module.lambda.role_name
  policy_arn = aws_iam_policy.dynamodb-access.arn
}

module "lambda" {
  source         = "../module/aws-lambda-rest-trigger"
  api_name       = "MaccasApi"
  api_version    = "v1"
  lambda_runtime = "provided.al2"
  lambda_handler = "bootstrap"
  api_routes     = [{ method = "ANY", route = "offers" }]
}
