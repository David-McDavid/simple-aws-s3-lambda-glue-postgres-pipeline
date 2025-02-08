resource "aws_s3_bucket" "glue_scripts" {
    bucket = var.bucket_name
}

resource "aws_s3_object" "script_files" {
    for_each = fileset("${path.module}/scripts", "**/*.py")

    bucket = aws_s3_bucket.glue_scripts.id
    key    = "scripts/${each.value}"
    source = "${path.module}/scripts/${each.value}" 
    etag   = filemd5("${path.module}/scripts/${each.value}")
}