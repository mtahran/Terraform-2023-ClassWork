terraform {
  backend "s3" {
    bucket = "mustafa-terraform-state-2023"
    key    = "ec2/terraform.tfstate"
    region = "us-east-1"
  }
}
