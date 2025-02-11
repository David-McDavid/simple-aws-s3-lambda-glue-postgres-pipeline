resource "aws_iam_role" "lambda_role" {
  name = var.lambda_role_name

  assume_role_policy = jsonencode({
  Version = "2012-10-17"
  Statement = [
    {
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }
  ]
  })
}

resource "aws_iam_policy_attachment" "lambda_policy" {
  name       = "lambda-policy-attachment"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "my_lambda" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  timeout       = var.lambda_timeout
  memory_size   = var.lambda_memory_size

  # The source code could be a zip file or S3 bucket
  # If you're using local files:
  filename      = var.lambda_filename
  source_code_hash = filebase64sha256(var.lambda_filename)

  # Environment variables (optional)
  environment {
    variables = var.lambda_environment_variables
  }
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.s3_drop_box_bucket_arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = var.s3_drop_box_bucket_id

  lambda_function {
    lambda_function_arn = aws_lambda_function.my_lambda.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_s3]
}