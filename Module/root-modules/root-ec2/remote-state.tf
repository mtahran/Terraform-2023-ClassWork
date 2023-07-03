data "terraform_remote_state" "newVPC" {
  backend = "s3"
  config = {
    bucket = "remote-state-tf-bucket"
    key  = "terraform/vpc.tfstate"
    region = "us-east-1"
  }

}