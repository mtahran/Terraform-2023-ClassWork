output "mustafat_hw-bucket_arn" {
  description = "ARN of the bucket"
  value       = aws_s3_bucket.mustafat-hw-bucket.arn
}

output "mustafat_hw-bucket_id" {
  description = "name of the bucket"
  value       = aws_s3_bucket.mustafat-hw-bucket.id
}
