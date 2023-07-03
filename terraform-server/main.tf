resource "aws_instance" "terraform-instance" {
  ami                  = data.aws_ami.amazon_linux2.image_id
  instance_type        = var.instance_type
  key_name             = var.key_name
  user_data            = file("user_data.sh")
  iam_instance_profile = aws_iam_instance_profile.terraform-instance-profile.name
  tags = {
    Name        = "${var.env}-terraform-server"
    Environment = var.env
  }
  depends_on = [
    data.aws_iam_policy_document.assume_role,
  ]
}

resource "aws_security_group" "terraform-security-group" {
  name        = "terraform-security-group"
  description = "Allow inbound traffic"
  tags = {
      Name = "terraform-security-group"
  } 
}

resource "aws_security_group_rule" "ingress" {
  for_each          = var.sg_ingress_rules
  type              = each.value.type
  protocol          = each.value.protocol
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  cidr_blocks       = [each.value.cidr_block]
  security_group_id = aws_security_group.terraform-security-group.id
}

resource "aws_security_group_rule" "egress" {
  for_each          = var.sg_egress_rules
  type              = each.value.type
  protocol          = each.value.protocol
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  cidr_blocks       = [each.value.cidr_block]
  security_group_id = aws_security_group.terraform-security-group.id
}