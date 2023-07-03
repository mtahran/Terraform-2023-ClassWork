variable "bucket_name" {
  default     = "mustafa-terraform-state-2023"
  description = "s3 bucket name"
  type        = string
}

variable "env" {
  default     = "prod"
  description = "production environment"
  type        = string
}