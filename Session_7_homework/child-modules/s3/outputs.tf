output "mustafat-hw-bucket.arn" {
  description = "ARN of the bucket"
  value       = aws_s3_bucket.mustafat-hw-bucket.arn
}

output "mustafat-hw-bucket.id" {
  description = "name of the bucket"
  value       = aws_s3_bucket.mustafat-hw-bucket.id
}
