resource "aws_secretsmanager_secret" "rds_secret" {
  name = "${var.db_identifier}-credentials"
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode({
    username = "user"  # You can also randomize this if needed
    password = random_password.db_password.result
  })
}

resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!@#%^&*()-_=+[]{}<>:?"
}

resource "aws_db_instance" "postgres" {
  identifier           = var.db_identifier
  engine               = "postgres"
  engine_version       = var.db_version
  instance_class       = var.instance_class
  allocated_storage    = var.allocated_storage
  storage_type         = "gp2"

  username             = jsondecode(aws_secretsmanager_secret_version.rds_secret_version.secret_string)["username"]
  password             = jsondecode(aws_secretsmanager_secret_version.rds_secret_version.secret_string)["password"]
  db_name              = var.db_name

  publicly_accessible  = var.publicly_accessible
  multi_az             = var.multi_az
  backup_retention_period = var.backup_retention
  skip_final_snapshot = true

  # vpc_security_group_ids = var.security_group_ids
  # db_subnet_group_name   = var.subnet_group_name

  tags = {
    Name = var.db_identifier
    Environment = var.environment
  }
}
