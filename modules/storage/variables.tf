variable "iam_user_app" {
  type = string
}

variable "s3_bucket_app" {
  type = string
}

variable "policy_name_app" {
  type = string
}

variable "rds_identifier" {
  description = "The identifier for the RDS instance"
  type = string
}

variable "rds_allocated_storage" {
  description = "The allocated storage for the RDS instance"
  type = number
}

variable "rds_storage_type" {
  description = "The storage type for the RDS instance"
  type = string
}

variable "rds_engine" {
  description = "The database engine for the RDS instance"
  type = string
}

variable "rds_engine_version" {
  description = "The engine version for the RDS instance"
  type = string
}

variable "rds_instance_class" {
  description = "The instance class for the RDS instance"
  type = string
}

variable "rds_username" {
  description = "The username for the RDS instance"
  type = string
}

variable "rds_password" {
  description = "The password for the RDS instance"
  type = string
  sensitive = true
}

variable "rds_db_subnet_group_name" {
  description = "The DB subnet group name for the RDS instance"
  type = string
}

variable "rds_vpc_security_group_ids" {
  description = "The VPC security group IDs for the RDS instance"
  type = list(string)
}

variable "rds_multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type = bool
}

variable "rds_skip_final_snapshot" {
  description = "Specifies if the RDS instance should skip the final snapshot"
  type = bool
}

variable "rds_backup_retention_period" {
  description = "The backup retention period for the RDS instance"
  type = number
}

variable "rds_publicly_accessible" {
  description = "Specifies if the RDS instance is publicly accessible"
  type = bool
}
