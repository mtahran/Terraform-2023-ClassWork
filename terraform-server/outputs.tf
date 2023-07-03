### AWS ###
output "amazon_linux_public_ip" {
  value = aws_instance.terraform-instance.public_ip
}

output "amazon_linux_private_ip" {
  value = aws_instance.terraform-instance.private_ip
}