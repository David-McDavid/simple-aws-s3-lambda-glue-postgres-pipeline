variable "glue_job_name" {
  description = "Name of the Glue job"
  type        = string
}

variable "script_location" {
  description = "S3 path to the Glue script"
  type        = string
}

variable "extra_jars" {
  description = "S3 path to additional JAR files"
  type        = string
  default     = ""
}

variable "max_retries" {
  description = "Maximum number of retries for the Glue job"
  type        = number
  default     = 2
}

variable "timeout" {
  description = "Timeout for the Glue job in minutes"
  type        = number
  default     = 2880
}

variable "worker_type" {
  description = "Type of worker for the Glue job"
  type        = string
  default     = "G.1X"
}

variable "number_of_workers" {
  description = "Number of workers for the Glue job"
  type        = number
  default     = 2
}

variable "glue_version" {
  description = "Glue version"
  type        = string
  default     = "3.0"
}