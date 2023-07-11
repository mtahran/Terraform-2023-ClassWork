# Providers variables
variable "aws_region" {
  type        = string
  description = "The region Terraform deploys my infrastructure"
}
variable "bucket_name" {
  type        = string
  description = "The name of the s3 bucket"
}

variable "env" {
  type        = string
  description = "the environment of the resources"
}

variable "github_kms_key" {
  description = "KMS key sourced from GitHub"
  default     = "https://github.com/mtahran/Terraform-2023-ClassWork/tree/main/homework/kms-key.txt"
}