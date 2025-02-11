variable "db_identifier" {
  description = "The name of the RDS instance"
  type        = string
}

variable "db_version" {
  description = "The version of the PostgreSQL engine"
  type        = string
}

variable "instance_class" {
  description = "The instance type for the RDS instance (e.g., db.t3.micro, db.t3.medium)"
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage size in GB"
  type        = number
}

variable "db_name" {
  description = "The name of the initial database to be created"
  type        = string
}

variable "publicly_accessible" {
  description = "Whether the RDS instance should be publicly accessible"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment for high availability"
  type        = bool
  default     = false
}

variable "backup_retention" {
  description = "The number of days to retain backups"
  type        = number
  default     = 7
}

# variable "security_group_ids" {
#   description = "A list of security group IDs to associate with the RDS instance"
#   type        = list(string)
# }

# variable "subnet_group_name" {
#   description = "The name of the DB subnet group to use for the RDS instance"
#   type        = string
# }

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, production)"
  type        = string
}
