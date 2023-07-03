data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners = [ "amazon" ]
  
  filter {
    name = "architecture"
    values = ["x86_64"]
  }

  filter {
    name = "name"
    values = ["al2023-ami-2023.0.20230614.0-kernel-6.1-x86_64"]
  }

  filter {
    name = "owner-id"
    values = ["137112412989"]
  }

}