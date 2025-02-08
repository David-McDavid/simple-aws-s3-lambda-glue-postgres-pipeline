provider "aws" {
    region = "us-east-1"
}

module "glue_scripts" {
    source = "./modules/s3"

    bucket_name = "glue_scripts"
}

module "glue_job" {
    source = "./modules/glue"

    glue_job_name   = "import_crime_data"
    script_location = "s3://glue_scripts/main.py"
    extra_jars      = ""
    max_retries     = 2
    timeout         = 2880
    worker_type     = "G.1X"
    number_of_workers = 2
    glue_version    = "4.0"
}

