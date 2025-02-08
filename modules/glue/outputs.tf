output "glue_job_name" {
  description = "Name of the Glue job"
  value       = aws_glue_job.learning_glue_job.name
}

output "glue_role_arn" {
  description = "ARN of the IAM role for the Glue job"
  value       = aws_iam_role.glue_role.arn
}