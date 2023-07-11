resource "aws_instance" "Terraform_Instance" {
  instance_type        = var.instance_type
  key_name             = var.key_name
  ami_id               = var.ima_id
  user_data            = file("userdata.sh")
  iam_instance_profile = aws_iam_instance_profile.ec2_instance.name
  security_groups      = aws_security_group.SG-for-instance.id
  tags                 = merge (
    local.common_tags,
    {
     name = "SG-for-instance -${var.env}"
    }
  )
}

resource "aws_security_group" "SG-for-instance" {
  name        = "allow ssh and https"
  description = "Allow ssh inbound, https outbound traffic"
  tags   = merge (
   local.common_tags, 
   {
    name = "SG-for-instance -${var.env}"
   }
  )
}

resource "aws_security_group_rule" "ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "ssh"
  cidr_blocks       = ["98.227.136.153/32","209.122.40.225/32"]
  security_group_id = aws_security_group.SG-for-instance.id
}

resource "aws_security_group_rule" "ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "http"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.SG-for-instance.id
}
resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "https"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.SG-for-instance.id
}

resource "aws_iam_instance_profile" "ec2_instance" {
  name = "test_profile"
  role = aws_iam_role.tf-role.name
}

resource "aws_iam_role" "tf-role" {
  name               = "tf-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags   = merge (
   local.common_tags, 
   {
    name = "SG-for-instance -${var.env}"
   }
  )
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazon.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}


