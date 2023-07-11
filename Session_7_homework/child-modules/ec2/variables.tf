variable "aws_region" {
  type        = string
  description = "The region Terraform deploys my infrastructure"
}

variable "aws_vpc" {
  type        = string
  description = "The region Terraform deploys my infrastructure"
}
variable "instance_ami" {
  type        = string
  description = "us-east-1, Amazon Linux 2023"
}
variable "instance_type" {
  type        = string
  description = "instance type for ec2 instance"
}

variable "key_name" {
  type        = string
  description = "key name to ssh to instance"
}

variable "kms_key_arn" {
  type        = string
  description = "enter kms key to encypt EBS volume"
}

variable "elastic_ip" {
  type        = string
  description = "elastci ip created with VPC"
}
variable "env" {
  type        = string
  description = "name of the environment"
}