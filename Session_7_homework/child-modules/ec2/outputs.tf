output "instance_arn" {
  value       = "aws_instance.myec2.arn"
  description = "ARN of the EC2 instance created"
}

output "sec_gr_id" {
  value       = "aws_security_group.sg_myec2.id"
  description = "ID of the security group for my EC2 instance"
}
