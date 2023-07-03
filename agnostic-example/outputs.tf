### Digital Ocean ###
output "do_web_public_ip" {
  value = digitalocean_droplet.server.ipv4_address
}

output "do_web_private_ip" {
  value = digitalocean_droplet.server.ipv4_address_private
}

### AWS ###
output "amazon_web_public_ip" {
  value = aws_instance.ec2.public_ip
}

output "amazon_web_private_ip" {
  value = aws_instance.ec2.private_ip
}