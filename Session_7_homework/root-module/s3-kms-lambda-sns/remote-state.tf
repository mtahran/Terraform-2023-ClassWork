data "terraform_remote_state" "kms-key" {
  backend = "s3"
  config = {
    bucket = "mustafat-terraform-backend-file"
    key    = "terraform/kms.tfstate"
    region = "us-east-1"
  }
}