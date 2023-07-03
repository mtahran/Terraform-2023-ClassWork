terraform {
  backend "remote" {
    bucket = "aws_s3_bucket_name"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}
