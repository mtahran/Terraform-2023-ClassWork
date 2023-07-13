variable "email" {
  default = "mutahran@gmail.com"
}

variable "env" {
  type        = string
  default = "dev"
  description = "the environment of the resources"
}

variable "github_kms_key" {
  description = "KMS key sourced from GitHub"
  default     = "https://github.com/mtahran/Terraform-2023-ClassWork/tree/main/homework/kms-key.txt"
}

variable "filter_prefix" {
  type        = string
  default = ""
  description = "Object key name prefix"
}

variable "filter_suffix" {
  type        = string
  default = ""
  description = "Object key name suffix"
}