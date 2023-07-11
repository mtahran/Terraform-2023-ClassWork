terraform {
  backend "remote" {
    bucket = "mustafat-remote-state"
    key    = "ec2/terraform.tfstate"
    dynamodb_table = "mustafat-remote-state-ddb"
    region = "us-east-1"
  }
}
