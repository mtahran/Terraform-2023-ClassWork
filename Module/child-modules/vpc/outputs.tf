output "eip_public_ip" {
  description = "Public IP of EIP needed to attached to ec2"
  value       = aws_eip.nat_gw_eip.public_ip
}