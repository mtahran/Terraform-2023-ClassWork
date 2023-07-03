data "aws_iam_policy_document" "s3-kms-key" {

  statement {
    sid = "Enable IAM User Permissions"

    actions   = ["kms:*"]
    resources = ["*"]
    principals = {
      type        = "AWS"
      identifiers = ["arn:aws:iam::937346363436:root"]
    }
  }
}
