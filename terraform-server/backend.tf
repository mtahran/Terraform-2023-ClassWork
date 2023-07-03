terraform {
  backend "s3" {
    bucket = "terraform-state-2023"
    key    = "terraform/terraform-server.tfstate"
    region = "us-east-1"
  }
}