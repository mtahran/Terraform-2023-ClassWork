variable "instance_type" {
  default     = "t2.micro"
  description = "instance type for ec2 instance"
  type        = string
}

variable "key_name" {
  default     = "macbook@400048mbp"
  description = "my local computer's keyname"
  type        = string
}

variable "ami_id" {
  default     = "ami-053b0d53c279acc90"
  description = "us-east-1 Ubuntu ami id"
  type        = string
}

variable "env" {
  default     = "prod"
  description = "production environment"
  type        = string
}
