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
  db_name = var.rds_db_name
}

# resource "aws_db_subnet_group" "infra_subnet_group" {
#   name = "infra-subnet-group"
#   subnet_ids = [
#     var.app_subnet_infra_1_id,
#     var.app_subnet_infra_2_id
#   ]
#   tags = {
#     Name = "Infra Subnet Group"
#   }
# }

# resource "aws_security_group" "app_rds_security_group" {
#   name = "app_rds-security-group"
#   vpc_id = var.vpc_id

#   ingress {
#     from_port = 5432
#     to_port = 5432
#     protocol = "tcp"
#     cidr_blocks = [var.vpc_cidr_block]
#   }
# }