output "eip_public_ip" {
  description = "Public IP of EIP needed to attached to ec2"
  value       = aws_eip.elastic_ip.public_ip
}

output "vpc_id" {
  value =  aws_vpc.newVPC.id
}