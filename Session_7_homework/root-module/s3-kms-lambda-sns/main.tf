module "s3" {
  source      = "../../child-modules/s3"
  bucket_name = "mustafat-hw-bucket"
  env = "dev"
  aws_region = "us-east-1"
}

data "aws_caller_identity" "current" {}

resource "aws_lambda_function" "s3_to_sns" {
  description = "sends SNS notification when an object is put into S3 bucket"
  function_name = "s3_to_sns"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "exports.example"
  runtime       = "python3.10"
  tags = merge(
    local.common_tags,
    {
      Name = "aws_lambda_function-s3_to_sns-${var.env}"
    }
  )
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  version = "2012-10-17"
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
  function_name = aws_lambda_function.s3_to_sns.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = module.s3.mustafat-hw-bucket.arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = module.s3.mustafat-hw-bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_to_sns.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = var.filter_prefix
    filter_suffix       = var.filter_suffix
  }
  depends_on = [aws_lambda_permission.allow_bucket]
}

resource "aws_lambda_function_event_invoke_config" "invoke_sns" {
  function_name = aws_lambda_function.s3_to_sns.function_name

  destination_config {
    on_success {
      destination = aws_sns_topic.sns_s3_lambda_topic.arn
    }
  }
}

### SNS Topic Resource published by Lambda Function
resource "aws_sns_topic" "sns_s3_lambda_topic" {
  name = "sns_s3_lambda_topic"
  kms_master_key_id = module.s3.github_kms_key
  tags = merge(
    local.common_tags,
    {
      Name = "aws_sns_topic-sns_s3_lambda_topic-${var.env}"
    }
  )
}

resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.sns_s3_lambda_topic.arn

  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "sns_topic_policy"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = ["${data.aws_caller_identity.current.account_id}"]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.sns_s3_lambda_topic.arn,
    ]

    sid = "SNS_permission_to_owner_resources "
  }
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.sns_s3_lambda_topic.arn
  protocol  = "email"
  endpoint  = var.email
}


