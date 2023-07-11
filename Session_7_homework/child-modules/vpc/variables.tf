# Providers variables
variable "aws_region" {
  type        = string
  description = "The region Terraform deploys my infrastructure"
}

# VPC variables
variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

#Subnet variables
variable "aws_az_1" {
  type        = string
  description = "The AZ for Public1 and Private1 Subnets"
}

variable "aws_az_2" {
  type        = string
  description = "The AZ for Public2 and Private2 Subnets"
}

variable "public_cidr1_subnet" {
  type        = string
  description = "CIDR block for the  1st public subnet"
}

variable "public_cidr2_subnet" {
  type        = string
  description = "CIDR block for the 2nd public subnet"
}

variable "private_cidr1_subnet" {
  type        = string
  description = "CIDR block for the 1st private subnet"
}

variable "private_cidr2_subnet" {
  type        = string
  description = "CIDR block for the 2nd private subnet"
}

# Tags variables
variable "env" {
  type        = string
  description = "name of the environment"
}
