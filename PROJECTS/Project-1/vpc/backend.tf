terraform {
  backend "s3" {
    bucket = "mustafat-terraform-backend-file"
    key    = "terraform/ec2.tfstate"
    region = "us-east-1"
  }
}