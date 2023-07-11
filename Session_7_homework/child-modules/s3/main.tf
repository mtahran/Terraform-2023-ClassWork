data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "mustafat-hw-bucket" {
  bucket = var.bucket_name
  tags = merge(
    local.common_tags,
    {
      Name = "mustafat-hw-bucket-${var.env}"
    }
  )
}

resource "aws_s3_bucket_acl" "mustafat-hw-bucket-acl" {
  bucket = aws_s3_bucket.mustafat-hw-bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "mustafat-hw-bucket-encry" {
  bucket = aws_s3_bucket.mustafat-hw-bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.github_kms_key
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_metric" "mustafat-hw-bucket-metrics" {
  bucket = aws_s3_bucket.mustafat-hw-bucket.id
  name   = "EntireBucket"
}

resource "aws_s3_bucket_versioning" "mustafat-hw-bucket-versioning" {
  bucket = aws_s3_bucket.mustafat-hw-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "mustafat-hw-bucket-log_bucket" {
  bucket = "mustafat-hw-bucket-log_bucket"
}

resource "aws_s3_bucket_logging" "mustafat-hw-bucket-logging" {
  bucket = aws_s3_bucket.mustafat-hw-bucket.id

  target_bucket = aws_s3_bucket.mustafat-hw-bucket-log_bucket.id
  target_prefix = "log/"
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.mustafat-hw-bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/tf-role"]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.mustafat-hw-bucket.arn}/*",
    ]
  }

  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/tf-role"]
    }

    actions = ["s3:ListBucket"]

    resources = [
      aws_s3_bucket.mustafat-hw-bucket.arn,
    ]
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "mustafat-hw-bucket-lifecycle" {
  bucket = aws_s3_bucket.mustafat-hw-bucket.id

  rule {
    id = "rule-1"
    expiration {
      days = 60
    }
    status = "Enabled"
  }
  
  rule {
    id = "rule-2"
    filter {
      and {
        prefix = "log/"
      }
    }
    status = "Enabled"

    transition {
      days          = 15
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 30
      storage_class = "GLACIER"
    }
    status = "Enabled"
  }

  rule {
    id = "rule-3"
    noncurrent_version_expiration {
      noncurrent_days = 90
    }
    status = "Enabled"
  }

  rule {
    id = "rule-4"
    abort_incomplete_multipart_upload {
        days_after_initiation = 7
    }
    status = "Enabled"
  }
}