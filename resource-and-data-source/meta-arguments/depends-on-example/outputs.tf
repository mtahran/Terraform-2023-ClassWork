output "amazon_web_private_ip" {
  value = aws_instance.terraform-instance.private_ip
}

output "amazon_web_public_ip" {
  value = aws_instance.terraform-instance.public_ip
}