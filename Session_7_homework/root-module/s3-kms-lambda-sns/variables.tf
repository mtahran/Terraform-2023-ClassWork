variable "email" {
  default = "mutahran@gmail.com"
}

variable "env" {
  type        = string
  default = "dev"
  description = "the environment of the resources"
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

variable "kms_master_key_id" {
  type = string
  default = data.terraform_remote_state.kms-key.arn
}

variable "bucket_name" {
  type = string
  default = "mustafat-terraform-backend-file"
}