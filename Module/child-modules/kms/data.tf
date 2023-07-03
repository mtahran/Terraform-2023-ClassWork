# data "aws_iam_policy_document" "s3-kms-key" {
#   statement {
#     effect = "Allow"
#     actions = ["kms:*"]
#     resources = ["*"]
#     sid = "EnableIAMUserPermissions"

#     resources = ["*"]
    
#     principals {
#       type        = "AWS"
#       identifiers = [
#         "arn:aws:iam::937346363436:role/tf-role-1",
#         "arn:aws:iam::937346363436:user/root"
#         ]
#     }

    
#   }
# }

data "aws_iam_policy_document" "s3-kms-key" {
  statement {
    sid = "Enable IAM User Permissions"

    actions = [
      "kms:*",
    ]

    resources = [
      "*",
    ]

    principals {
        type = "AWS"
        identifiers = ["arn:aws:iam::937346363436:root"]
    }
    }
}