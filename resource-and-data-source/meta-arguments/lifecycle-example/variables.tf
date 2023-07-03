variable "sg_ingress_rules" {
  type = map(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))
  default = {
    1 = {
      type        = "ingress"
      protocol    = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_block  = "71.201.6.150/32"
      description = "test"
    },
    2 = {
      type        = "ingress"
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      cidr_block  = "0.0.0.0/0"
      description = "test"
    }
  }
}

### AWS Credentials ###
variable "aws_secret_key" {
  default = ""
}

variable "aws_access_key" {
  default = ""
}