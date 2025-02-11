provider "aws" {
  region = "us-east-1"
}

/*
  Terraform s3 backend needs to be created with the backend module first.
  After you run your first terraform apply to create them you can uncomment
  the code block to move the tf state to being remote instead of local.
*/

# terraform {
#   backend "s3" {
#     bucket         = local.tf_state_s3_bucket_name
#     key            = "path/to/your/statefile.tfstate"
#     region         = local.aws_region
#     encrypt        = true
#     dynamodb_table = local.tf_state_dynamodb_table_name
#   }
# }

module "backend" {
  source              = "./modules/tfstate"
  s3_bucket_name      = local.tf_state_s3_bucket_name
  dynamodb_table_name = local.tf_state_dynamodb_table_name
}

module "s3_buckets" {
  source = "./modules/s3"

  glue_scripts_bucket_name = local.glue_scripts_bucket_name
  glue_drop_box_bucket = local.glue_drop_box_bucket
}

module "glue_job" {
  source = "./modules/glue"

  glue_job_name   = local.glue_job_name
  script_location = local.script_location
  extra_jars      = local.extra_jars
  max_retries     = 2
  timeout         = 2880
  worker_type     = "G.1X"
  number_of_workers = 2
  glue_version    = "4.0"
}

module "lambda" {
  source = "./modules/lambda"

  lambda_function_name       = local.lambda_function_name
  lambda_role_name           = local.lambda_role_name
  lambda_handler             = "${local.lambda_function_name}.${local.lambda_function_handler}"
  lambda_runtime             = "python3.13"
  lambda_filename            = local.lambda_zipile_name
  lambda_timeout             = 30
  lambda_memory_size         = 256

  s3_drop_box_bucket_id      = module.s3_buckets.glue_drop_box_bucket_id
  s3_drop_box_bucket_arn     = module.s3_buckets.glue_drop_box_bucket_arn
}

module "rds" {
  source              = "./modules/rds"
  db_identifier       = "my-postgres-db"
  db_version          = "17.2"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  db_name             = "mydatabase"
  publicly_accessible = false
  multi_az            = false
  backup_retention    = 7
  # security_group_ids  = [aws_security_group.rds_sg.id]
  # subnet_group_name   = aws_db_subnet_group.default.name
  environment         = "dev"
}

