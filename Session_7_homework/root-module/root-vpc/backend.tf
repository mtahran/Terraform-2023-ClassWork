terraform {
  backend "s3" {
    bucket = "mustafat-terraform-backend-file"
    key    = "terraform/vpc.tfstate"
    region = "us-east-1"
  }
}