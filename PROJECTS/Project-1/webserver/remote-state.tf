data "terraform_remote_state" "project-vpc" {
  backend = "s3"
  config = {
    bucket = "mustafat-terraform-backend-file"
    key    = "terraform/vpc.tfstate"
    region = "us-east-1"
  }
}