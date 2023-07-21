output "kms-key-id" {
  value       = "aws_kms_key.kms-key.key_id"
  description = "kms key id output"
}

output "kms-key-alias-name" {
  value       = "aws_kms_alias.kms-key-name.name"
  description = "kms key id output"
}
