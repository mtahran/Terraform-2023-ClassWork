resource "aws_instance" "ec2" {
  ami           = data.aws_ami.amazon_linux2.image_id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.tf-sg-first.id]
  key_name               = "new-key"
  tags = {
    Name = "terraform-instance"
  }
}

resource "aws_security_group" "tf-sg-first" {
  name        = "tf-sg-first"
  description = "Allow inbound traffic"
  tags = {
      Name = "tf-sg-first"
  } 
}

resource "aws_security_group_rule" "ingress" {
  for_each          = var.sg_ingress_rules
  type              = each.value.type
  protocol          = each.value.protocol
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  cidr_blocks       = [each.value.cidr_block]
  security_group_id = aws_security_group.tf-sg-first.id
}