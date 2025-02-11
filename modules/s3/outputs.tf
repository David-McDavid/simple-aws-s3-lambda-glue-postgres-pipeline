output "glue_drop_box_bucket_id" {
  description = "ID for the Glue Scripts Bucket"
  value       = aws_s3_bucket.drop_box.id
}

output "glue_drop_box_bucket_arn" {
  description = "ID for the Glue Scripts Bucket"
  value       = aws_s3_bucket.drop_box.arn
}