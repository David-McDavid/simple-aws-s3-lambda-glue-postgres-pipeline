variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "lambda_role_name" {
  description = "The name of the IAM role for Lambda"
  type        = string
}

variable "lambda_handler" {
  description = "The function handler (e.g., index.handler)"
  type        = string
}

variable "lambda_runtime" {
  description = "The Lambda runtime (e.g., nodejs14.x)"
  type        = string
}

variable "lambda_timeout" {
  description = "The timeout for the Lambda function in seconds"
  type        = number
  default     = 60
}

variable "lambda_memory_size" {
  description = "The memory allocated for the Lambda function (MB)"
  type        = number
  default     = 128
}

variable "lambda_filename" {
  description = "The local path to the Lambda function code (zip file)"
  type        = string
}

variable "lambda_environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "s3_drop_box_bucket_id" {
  description = "S3 Drop Box Bucket Id"
  type        = string
}

variable "s3_drop_box_bucket_arn" {
  description = "S3 Drop Box Bucket Arn"
  type        = string
}