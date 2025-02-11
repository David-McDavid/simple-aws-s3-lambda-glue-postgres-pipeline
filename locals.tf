locals {
  aws_region                    = "us-east-1"
  unique_prefix                 = "sample-unique-prefix"
  # S3
  glue_scripts_bucket_name      = "${local.unique_prefix}-glue-scripts"
  glue_drop_box_bucket          = "${local.unique_prefix}-drop-box"

  # Glue
  glue_job_name                 = "crime_data_pipeline"
  script_location               = "s3://${local.glue_drop_box_bucket}/main.py"
  extra_jars                    = ""

  # Lambda
  lambda_function_name          = "kick_off_glue_job"
  lambda_role_name              = "lambda-execution-role"
  lambda_function_handler       = "onS3EventHandler"
  lambda_zipile_name            = "lambda_code.zip"

  # TF State
  tf_state_s3_bucket_name       = "${local.unique_prefix}-my-terraform-state-bucket"
  tf_state_dynamodb_table_name  = "terraform-lock-table"
}