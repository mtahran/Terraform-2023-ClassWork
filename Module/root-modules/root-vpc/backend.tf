terraform {
  backend "s3" {
    bucket = "mustafa-terraform-state-2023"
    key    = "terraform/vpc.tfstate"
    region = "us-east-1"
  }
}