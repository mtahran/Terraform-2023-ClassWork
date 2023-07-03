variable "env" {
  description = "name of the env"
  default     = "dev"
  type        = string
}

variable "instance_type" {
  description = "instance type"
  default     = "t2.micro"
  type        = string
}

variable "key_name" {
  description = "instance type"
  default     = "new-key"
  type        = string
}