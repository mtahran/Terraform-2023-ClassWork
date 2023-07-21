resource "aws_kms_key" "kms-key" {
  description = var.description
  deletion_window_in_days = var.deletion_window_in_days
  is_enabled = var.is_enabled
  enable_key_rotation = var.enable_key_rotation
  policy = data.aws_iam_policy_document.s3-kms-key.json
  tags = merge (
    local.common_tags,
    {
      Name = "kms-${random_string.kms-key-name.result}"
    }
  )
}

resource "aws_kms_alias" "kms-key-alias" {
  depends_on = [ aws_kms_key.kms-key]
  name          = "alias/kms-key-${random_id.alias-key-name.hex}"
  target_key_id = aws_kms_key.kms-key.id
}

resource "random_id" "alias-key-name" {
  byte_length = 7
}

resource "random_string" "kms-key-name" {
    keepers = {
      name = local.appname
    }
  special = false
  upper = "true"
  length = 8
}

# resource "aws_kms_key_policy" "s3-kms-key-policy" {
#   key_id = aws_kms_key.kms-key.id
#   policy = templatefile("policy/kms.json")
# }