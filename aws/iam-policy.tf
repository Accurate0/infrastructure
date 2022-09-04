resource "aws_iam_group_policy" "terraform-group-policy-1" {
  name  = "terraform-group-policy-1"
  group = aws_iam_group.terraform-users.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "apigateway:*"
        ],
        "Resource" : "arn:aws:apigateway:*::/*"
      },
      {
        "Action" : [
          "s3:ListAllMyBuckets"
        ],
        "Effect" : "Allow",
        "Resource" : "arn:aws:s3:::*"
      },
      {
        "Action" : [
          "acm:ListCertificates",
          "cloudfront:*",
          "iam:ListServerCertificates",
          "waf:ListWebACLs",
          "waf:GetWebACL",
          "wafv2:ListWebACLs",
          "wafv2:GetWebACL",
          "kinesis:ListStreams"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : [
          "kinesis:DescribeStream"
        ],
        "Effect" : "Allow",
        "Resource" : "arn:aws:kinesis:*:*:*"
      },
      {
        "Action" : [
          "iam:ListRoles"
        ],
        "Effect" : "Allow",
        "Resource" : "arn:aws:iam::*:*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "acm:*"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "iam:CreateServiceLinkedRole",
        "Resource" : "arn:aws:iam::*:role/aws-service-role/acm.amazonaws.com/AWSServiceRoleForCertificateManager*",
        "Condition" : {
          "StringEquals" : {
            "iam:AWSServiceName" : "acm.amazonaws.com"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:DeleteServiceLinkedRole",
          "iam:GetServiceLinkedRoleDeletionStatus",
          "iam:GetRole"
        ],
        "Resource" : "arn:aws:iam::*:role/aws-service-role/acm.amazonaws.com/AWSServiceRoleForCertificateManager*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:*",
          "organizations:DescribeAccount",
          "organizations:DescribeOrganization",
          "organizations:DescribeOrganizationalUnit",
          "organizations:DescribePolicy",
          "organizations:ListChildren",
          "organizations:ListParents",
          "organizations:ListPoliciesForTarget",
          "organizations:ListRoots",
          "organizations:ListPolicies",
          "organizations:ListTargetsForPolicy"
        ],
        "Resource" : "*"
      },
      {
        "Action" : [
          "autoscaling:Describe*",
          "cloudwatch:*",
          "logs:*",
          "sns:*",
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:GetRole"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "iam:CreateServiceLinkedRole",
        "Resource" : "arn:aws:iam::*:role/aws-service-role/events.amazonaws.com/AWSServiceRoleForCloudWatchEvents*",
        "Condition" : {
          "StringLike" : {
            "iam:AWSServiceName" : "events.amazonaws.com"
          }
        }
      },
      {
        "Sid" : "CloudWatchEventsFullAccess",
        "Effect" : "Allow",
        "Action" : "events:*",
        "Resource" : "*"
      },
      {
        "Sid" : "IAMPassRoleForCloudWatchEvents",
        "Effect" : "Allow",
        "Action" : "iam:PassRole",
        "Resource" : "arn:aws:iam::*:role/AWS_Events_Invoke_Targets"
      },
      {
        "Action" : "cloudwatch:GetInsightRuleReport",
        "Effect" : "Allow",
        "Resource" : "arn:aws:cloudwatch:*:*:insight-rule/DynamoDBContributorInsights*"
      },
      {
        "Action" : [
          "iam:PassRole"
        ],
        "Effect" : "Allow",
        "Resource" : "*",
        "Condition" : {
          "StringLike" : {
            "iam:PassedToService" : [
              "application-autoscaling.amazonaws.com",
              "application-autoscaling.amazonaws.com.cn",
              "dax.amazonaws.com"
            ]
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:CreateServiceLinkedRole"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringEquals" : {
            "iam:AWSServiceName" : [
              "replication.dynamodb.amazonaws.com",
              "dax.amazonaws.com",
              "dynamodb.application-autoscaling.amazonaws.com",
              "contributorinsights.dynamodb.amazonaws.com",
              "kinesisreplication.dynamodb.amazonaws.com"
            ]
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : "organizations:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "account:PutAlternateContact",
          "account:DeleteAlternateContact",
          "account:GetAlternateContact"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "iam:CreateServiceLinkedRole",
        "Resource" : "*",
        "Condition" : {
          "StringEquals" : {
            "iam:AWSServiceName" : "organizations.amazonaws.com"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:*",
          "s3-object-lambda:*"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "cloudformation:DescribeStacks",
          "cloudformation:ListStackResources",
          "cloudwatch:ListMetrics",
          "cloudwatch:GetMetricData",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs",
          "kms:ListAliases",
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:GetRole",
          "iam:GetRolePolicy",
          "iam:ListAttachedRolePolicies",
          "iam:ListRolePolicies",
          "iam:ListRoles",
          "lambda:*",
          "logs:DescribeLogGroups",
          "states:DescribeStateMachine",
          "states:ListStateMachines",
          "tag:GetResources",
          "xray:GetTraceSummaries",
          "xray:BatchGetTraces"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "iam:PassRole",
        "Resource" : "*",
        "Condition" : {
          "StringEquals" : {
            "iam:PassedToService" : "lambda.amazonaws.com"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:DescribeLogStreams",
          "logs:GetLogEvents",
          "logs:FilterLogEvents"
        ],
        "Resource" : "arn:aws:logs:*:*:log-group:/aws/lambda/*"
      }
    ]
  })
}

resource "aws_iam_group_policy" "terraform-group-policy-2" {
  name  = "terraform-group-policy-2"
  group = aws_iam_group.terraform-users.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Action" : [
          "dynamodb:*",
          "dax:*",
          "application-autoscaling:DeleteScalingPolicy",
          "application-autoscaling:DeregisterScalableTarget",
          "application-autoscaling:DescribeScalableTargets",
          "application-autoscaling:DescribeScalingActivities",
          "application-autoscaling:DescribeScalingPolicies",
          "application-autoscaling:PutScalingPolicy",
          "application-autoscaling:RegisterScalableTarget",
          "cloudwatch:DeleteAlarms",
          "cloudwatch:DescribeAlarmHistory",
          "cloudwatch:DescribeAlarms",
          "cloudwatch:DescribeAlarmsForMetric",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:ListMetrics",
          "cloudwatch:PutMetricAlarm",
          "cloudwatch:GetMetricData",
          "datapipeline:ActivatePipeline",
          "datapipeline:CreatePipeline",
          "datapipeline:DeletePipeline",
          "datapipeline:DescribeObjects",
          "datapipeline:DescribePipelines",
          "datapipeline:GetPipelineDefinition",
          "datapipeline:ListPipelines",
          "datapipeline:PutPipelineDefinition",
          "datapipeline:QueryObjects",
          "ec2:DescribeVpcs",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "iam:GetRole",
          "iam:ListRoles",
          "kms:DescribeKey",
          "kms:ListAliases",
          "sns:CreateTopic",
          "sns:DeleteTopic",
          "sns:ListSubscriptions",
          "sns:ListSubscriptionsByTopic",
          "sns:ListTopics",
          "sns:Subscribe",
          "sns:Unsubscribe",
          "sns:SetTopicAttributes",
          "lambda:CreateFunction",
          "lambda:ListFunctions",
          "lambda:ListEventSourceMappings",
          "lambda:CreateEventSourceMapping",
          "lambda:DeleteEventSourceMapping",
          "lambda:GetFunctionConfiguration",
          "lambda:DeleteFunction",
          "resource-groups:ListGroups",
          "resource-groups:ListGroupResources",
          "resource-groups:GetGroup",
          "resource-groups:GetGroupQuery",
          "resource-groups:DeleteGroup",
          "resource-groups:CreateGroup",
          "tag:GetResources",
          "kinesis:ListStreams",
          "kinesis:DescribeStream",
          "kinesis:DescribeStreamSummary"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_group_policy" "terraform-group-policy-3" {
  name  = "terraform-group-policy-3"
  group = aws_iam_group.terraform-users-2.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Action" : [
          "sqs:*"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}
