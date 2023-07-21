output "kms_key_id" {
  value = module.s3-kms-key.kms-key-id
}

output "aws_kms_alias" {
  value = module.s3-kms-key.kms-key-alias-name
}