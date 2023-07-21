variable "deletion_window_in_days" {
  type        = number
  description = "delete kms key in 7 days"
}

variable "description" {
  type        = string
  description = "kms key for s3 bucket"
}

variable "is_enabled" {
  type        = bool
  description = "true by default or change to false"
}

variable "enable_key_rotation" {
  type        = bool
  description = "enable ky rotation is true/false"
}