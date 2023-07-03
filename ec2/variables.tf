variable "instance_type" {
  default = "t2.micro"
  description = "instance type for webserver"
  type = string
}

variable "vpc_id" {
  default = "vpc-0bafa79a91572a3ac"
  type = string
}

variable "ssh_from_port" {
  default = 22
  description = "this is from port to ssh sg"
  type = number
}

variable "ssh_to_port" {
  default = 22
  description = "this is to port for ssh sg"
  type = number
}

variable "protocol" {
  default = "tcp"
  description = "this is tcp port"
  type = string
}

variable "key_name" {
  default = "macbook@400048mbp"
  description = "My Macbook's Key Pair"
  type = string
}

variable "env" {
  default = "prod"
  description = "prod environment"
  type = string
}
variable "aws_access_key" {
  default = ""
  type = string
}

variable "aws_secret_key" {
  default = ""
  type = string
}
