module "s3-bucket-kms" {
  source                  = "../../Module/child-modules/kms"
  description             = "kms key for s3 bucket"
  deletion_window_in_days = 7
  is_enabled              = true
  enable_key_rotation     = true
}


resource "aws_s3_bucket" "remote-state" {
  bucket = var.bucket_name
  tags = merge(
    local.common_tags,
    {
      name = "remote-state-terraform -${var.env}"
    }
  )
}
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encrypt" {
  bucket = aws_s3_bucket.remote-state.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = module.s3-bucket-kms.kms-key-id
      sse_algorithm     = "aws:kms"
      # sse_algorithm     = "AES256"
    }
  }
}
resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.remote-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.remote-state.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::937346363436:role/tf-role-1"]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = [
      aws_s3_bucket.remote-state.arn,
      "${aws_s3_bucket.remote-state.arn}/*",
    ]
  }

  statement {
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::937346363436:role/tf-role-1"]
    }

    actions = ["s3:ListBucket"]

    resources = [
      aws_s3_bucket.remote-state.arn,
      "${aws_s3_bucket.remote-state.arn}/*",
    ]
  }
}


