resource "aws_s3_bucket" "glue_scripts" {
  bucket = var.glue_scripts_bucket_name
}

resource "aws_s3_object" "script_files" {
  for_each = fileset("${path.module}/scripts", "**/*.py")

  bucket = aws_s3_bucket.glue_scripts.id
  key    = "scripts/${each.value}"
  source = "${path.module}/scripts/${each.value}" 
  etag   = filemd5("${path.module}/scripts/${each.value}")
}

resource "aws_s3_bucket" "drop_box" {
  bucket = var.glue_drop_box_bucket
}

resource "aws_s3_bucket_policy" "glue_scripts_policy" {
  bucket = aws_s3_bucket.glue_scripts.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "glue.amazonaws.com"
        }
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.glue_scripts.id}",
          "arn:aws:s3:::${aws_s3_bucket.glue_scripts.id}/*"
        ]
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "drop_box_policy" {
  bucket = aws_s3_bucket.drop_box.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "glue.amazonaws.com"
        }
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.drop_box.id}",
          "arn:aws:s3:::${aws_s3_bucket.drop_box.id}/*"
        ]
      }
    ]
  })
}
