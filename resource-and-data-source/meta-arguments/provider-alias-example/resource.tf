resource "aws_instance" "server-us-east-1" {
  ami           = "ami-0715c1897453cabd1"
  instance_type = "t2.micro"
  tags = {
    Name = "tf-instance-1"
  }
}

resource "aws_instance" "server-us-west-2" {
  provider      = aws.west
  ami           = "ami-07dfed28fcf95241c"
  instance_type = "t2.micro"
  tags = {
    Name = "tf-instance-2"
  }
}