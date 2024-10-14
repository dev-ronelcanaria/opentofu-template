resource "aws_db_instance" "rds" {
  identifier = var.rds_identifier
  allocated_storage = var.rds_allocated_storage
  storage_type = var.rds_storage_type
  engine = var.rds_engine
  engine_version = var.rds_engine_version
  instance_class = var.rds_instance_class
  username = var.rds_username
  password = var.rds_password
  db_subnet_group_name = var.rds_db_subnet_group_name
  vpc_security_group_ids = var.rds_vpc_security_group_ids
  multi_az = var.rds_multi_az
  skip_final_snapshot = var.rds_skip_final_snapshot
  backup_retention_period = var.rds_backup_retention_period
  publicly_accessible = var.rds_publicly_accessible
}

output "rds_endpoint" {
  value = aws_db_instance.rds.endpoint
}