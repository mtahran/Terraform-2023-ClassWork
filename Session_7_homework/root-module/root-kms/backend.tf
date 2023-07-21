terraform {
  backend "s3" {
    bucket = "mustafat-terraform-backend-file"
    key    = "terraform/kms.tfstate"
    region = "us-east-1"
  }
}