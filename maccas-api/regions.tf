module "refresh-syd" {
  source   = "./module/refresh-regional-lambda"
  role_arn = aws_iam_role.iam.arn
  region   = "ap-southeast-2"
}

module "refresh-sng" {
  source   = "./module/refresh-regional-lambda"
  role_arn = aws_iam_role.iam.arn
  region   = "ap-southeast-1"
}

module "refresh-tok" {
  source   = "./module/refresh-regional-lambda"
  role_arn = aws_iam_role.iam.arn
  region   = "ap-northeast-1"
}

module "refresh-seo" {
  source   = "./module/refresh-regional-lambda"
  role_arn = aws_iam_role.iam.arn
  region   = "ap-northeast-2"
}
