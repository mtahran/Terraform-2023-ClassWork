variable "instance_type" {
  default     = "t2.micro"
  description = "instance type"
}

variable "env" {
  description = "environment"
  default     = "dev"
}

variable "key_name" {
  description = "key name"
  default     = "local-key"
}

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
      cidr_block  = "0.0.0.0/0"
      description = "office"
    },
    2 = {
      type        = "ingress"
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      cidr_block  = "0.0.0.0/0"
      description = "local"
    }
  }
}

variable "sg_egress_rules" {
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
      from_port   = -1
      to_port     = -1
      cidr_block  = "0.0.0.0/0"
      description = "outbound"
    }
  }
}