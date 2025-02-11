resource "aws_iam_policy" "glue_policy" {
  name        = "glue_policy"
  description = "IAM policy for Glue to access S3 and CloudWatch Logs"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "glue_role" {
  name = "glue_role"

  assume_role_policy = jsonencode({
  Version = "2012-10-17"
  Statement = [
    {
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "glue.amazonaws.com"
      }
    },
  ]
  })
}

resource "aws_iam_role_policy_attachment" "glue_policy_attachment" {
  role       = aws_iam_role.glue_role.name
  policy_arn = aws_iam_policy.glue_policy.arn
}

resource "aws_glue_job" "learning_glue_job" {
  name     = var.glue_job_name
  role_arn = aws_iam_role.glue_role.arn

  command {
  script_location = var.script_location
  }

  default_arguments = {
  "--extra-jars"            = var.extra_jars
  "--enable-continuous-cloudwatch-log" = "true"
  "--enable-metrics"        = "true"
  }

  max_retries = var.max_retries

  timeout = var.timeout

  worker_type       = var.worker_type
  number_of_workers = var.number_of_workers

  glue_version = var.glue_version
}