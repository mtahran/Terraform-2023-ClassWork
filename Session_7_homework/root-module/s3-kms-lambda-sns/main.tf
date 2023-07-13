module "s3" {
  bucket_name = "mustafat-hw-bucket"
  env = "dev"
  aws_region = "us-east-1"
}

resource "aws_lambda_function" "s3_to_sns" {
  description = "sends SNS notification when an object is put into S3 bucket"
  function_name = "s3_to_sns"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "exports.example"
  runtime       = "go1.x"
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
data "aws_iam_policy_document" "assume_role" {
  Version = "2012-10-17"
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}



resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_to_sns.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.mustafat-hw-bucket.arn
}



resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.mustafa-hw-bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.func.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "AWSLogs/"
    filter_suffix       = ".log"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}

### SNS Topic Resource published by Lambda Function
resource "aws_sns_topic" "sns_s3_lambda_topic" {}

resource "aws_lambda_function" "lambda_function" {
  function_name    = "TopicPublisherFunction"
  filename         = data.archive_file.lambda_zip_file.output_path
  source_code_hash = data.archive_file.lambda_zip_file.output_base64sha256
  handler          = "app.handler"
  role             = aws_iam_role.lambda_iam_role.arn
  runtime          = "nodejs14.x"
  environment {
    variables = {
      SNStopic = aws_sns_topic.sns_topic.arn
    }
  }
}

data "archive_file" "lambda_zip_file" {
  type        = "zip"
  source_file = "${path.module}/src/app.js"
  output_path = "${path.module}/lambda.zip"
}

data "aws_iam_policy" "lambda_basic_execution_role_policy" {
  name = "AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role" "lambda_iam_role" {
  name_prefix         = "LambdaSNSRole-"
  managed_policy_arns = [
    data.aws_iam_policy.lambda_basic_execution_role_policy.arn,
    aws_iam_policy.lambda_policy.arn
  ]

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

data "aws_iam_policy_document" "lambda_policy_document" {
  statement {
  
    effect = "Allow"
  
    actions = [
      "sns:Publish"
    ]

    resources = [
      aws_sns_topic.sns_topic.arn
    ]
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name_prefix = "lambda_policy-"
  path        = "/"
  policy      = data.aws_iam_policy_document.lambda_policy_document.json
  lifecycle {
    create_before_destroy = true
  }
}

output "TopicPublisherFunction" {
  value       = aws_lambda_function.lambda_function.arn
  description = "TopicPublisherFunction function name"
}

output "SNStopicARN" {
  value       = aws_sns_topic.sns_topic.arn
  description = "SNS topic ARN"
}
