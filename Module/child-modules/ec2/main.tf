resource "aws_instance" "myec2" {
    ami           = var.instance_ami
    instance_type = var.instance_type
    key_name      = var.key_name
    user_data     = file("template-file/user_data.sh")
    vpc_security_group_ids = [aws_security_group.sg_myec2.id]
    tags = merge (
      local.common_tags,
      {
        Name  = "myec2-${var.env}-${random_pet.ec2_name.id}" 
      }   
    )
}
resource "random_pet" "ec2_name" {
  length    = 2
  separator = "-"
}

resource "aws_ebs_volume" "ebs_to_myec2" {
  availability_zone = "us-east-1a"
  size              = 40
  kms_key_id = aws_kms_key.kms-key.key_id
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_ebs"
    }
  )
}
resource "aws_volume_attachment" "ebs_to_myec2" {


  
}

resource "aws_security_group" "sg_myec2" {
  name        = "sg_myec2"
  description = "Allow ssh and http inbound traffic"
  vpc_id      = aws_vpc.newVPC.id

  ingress {
    description      = "open to http from internet"
    from_port        = 80
    to_port          = 80
    protocol         = "http"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "open to ssh from internet"
    from_port        = 22
    to_port          = 22
    protocol         = "ssh"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sg_myec2-${var.env}-${random_pet.ec2_name.id}"
  }
}