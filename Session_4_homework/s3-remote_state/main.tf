
data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "mustafat-remote-state" {
  bucket = var.bucket_name
  tags = merge(
    local.common_tags,
    {
      name = "remote-state-terraform -${var.env}"
    }
  )
}
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encrypt" {
  bucket = aws_s3_bucket.mustafat-remote-state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.mustafat-remote-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.mustafat-remote-state.id
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
      "${aws_s3_bucket.mustafat-remote-state.arn}/*",
    ]
  }

  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/tf-role"]
    }

    actions = ["s3:ListBucket"]

    resources = [
      aws_s3_bucket.mustafat-remote-state.arn,
    ]
  }
}


