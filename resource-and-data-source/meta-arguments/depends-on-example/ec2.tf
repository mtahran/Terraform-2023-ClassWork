resource "aws_instance" "terraform-instance" {
  ami                  = data.aws_ami.amazon_linux2.image_id
  instance_type        = var.instance_type
  key_name             = var.key_name
  iam_instance_profile = aws_iam_instance_profile.terraform-instance-profile.name
  tags = {
    Name        = "${var.env}-server"
    Environment = var.env
  }
  depends_on = [
    data.aws_iam_policy_document.assume_role,
  ]
}