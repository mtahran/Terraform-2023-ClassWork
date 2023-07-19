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
  default = "arn:aws:kms:us-east-1:937346363436:key/67f10b11-d00b-4a76-893b-c25eea0159c8"
}

variable "bucket_name" {
  type = string
  default = ""
}