data "terraform_remote_state" "newVPC" {
  backend = "s3"
  config = {
    bucket = "mustafat-terraform-backend-file"
    key    = "terraform/vpc.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "kms-key" {
  backend = "s3"
  config = {
    bucket = "mustafat-terraform-backend-file"
    key    = "terraform/kms.tfstate"
    region = "us-east-1"
  }
}