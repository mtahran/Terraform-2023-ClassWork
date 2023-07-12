resource "aws_instance" "Terraform_Instance" {
  instance_type          = var.instance_type
  key_name               = var.key_name
  ami                    = var.ami_id
  user_data              = file("userdata.sh")
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance.name
  vpc_security_group_ids = [aws_security_group.SG-for-instance.id]
  tags = merge(
    local.common_tags,
    {
      name = "SG-for-instance -${var.env}"
    }
  )
}

resource "aws_security_group" "SG-for-instance" {
  name        = "allow ssh and https"
  description = "Allow ssh inbound, https outbound traffic"
  tags = merge(
    local.common_tags,
    {
      name = "SG-for-instance -${var.env}"
    }
  )
}

resource "aws_security_group_rule" "ingress-1" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["98.227.136.153/32", "209.122.40.225/32"]
  security_group_id = aws_security_group.SG-for-instance.id
}

resource "aws_security_group_rule" "ingress-2" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.SG-for-instance.id
}
resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.SG-for-instance.id
}

resource "aws_iam_instance_profile" "ec2_instance" {
  name = "test_profile"
  role = aws_iam_role.tf-role.name
}

# tf-role and 1st Policy attached to it.
resource "aws_iam_role" "tf-role" {
  name               = "tf-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.terraform-assume-policy.json
  tags = merge(
    local.common_tags,
    {
      name = "SG-for-instance -${var.env}"
    }
  )
}

data "aws_iam_policy_document" "terraform-assume-policy" {
  statement {
    sid    = "terraformassumepolicy"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}
# 2nd Policy attached to tf-role
resource "aws_iam_policy" "policy" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"
  policy      = data.aws_iam_policy_document.full_access.json

}

data "aws_iam_policy_document" "full_access" {
  statement {
    sid       = "AllowFullAccess"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["*"]
  }
}

resource "aws_iam_policy_attachment" "full_access" {
  name       = "test-attachment"
  roles      = [aws_iam_role.tf-role.name]
  policy_arn = aws_iam_policy.policy.arn
}
