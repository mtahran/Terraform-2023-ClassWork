module "vpc" {
  source               = "../../child-modules/vpc"
  aws_region           = "us-east-1"
  vpc_cidr_block       = "10.0.0.0/22"
  private_cidr1_subnet = "10.0.0.0/24"
  private_cidr2_subnet = "10.0.1.0/24"
  public_cidr1_subnet  = "10.0.2.0/24"
  public_cidr2_subnet  = "10.0.3.0/24"
  aws_az_1             = "us-east-1a"
  aws_az_2             = "us-east-1b"
  env                  = "dev"
}