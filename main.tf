module "network" {
  source = "./modules/network"
  
  vpc_name = var.vpc_name
  vpc_cidr_block = var.vpc_cidr_block
  vpc_subnet_1_name = var.vpc_subnet_1_name
  vpc_subnet_1_cidr_block = var.vpc_subnet_1_cidr_block
  vpc_subnet_1_availability_zone = var.vpc_subnet_1_availability_zone
  vpc_subnet_2_name = var.vpc_subnet_2_name
  vpc_subnet_2_cidr_block = var.vpc_subnet_2_cidr_block
  vpc_subnet_2_availability_zone = var.vpc_subnet_2_availability_zone
  vpc_igw = var.vpc_igw
  vpc_rtb_cidr_block = var.vpc_rtb_cidr_block
}

module "pipeline" {
  source = "./modules/pipeline"

  app_ecr_name = var.app_ecr_name
  ecs_cluster_name = var.ecs_cluster_name
  app_taskdef_family = var.app_taskdef_family
  app_container_name = var.app_container_name
  app_ecs_service_name = var.app_ecs_service_name
}

module "servers" {
  source = "./modules/servers"
  app_name = var.app_name

  app_subnet_1_id = module.network.app_subnet_1_id
  app_subnet_2_id = module.network.app_subnet_2_id
  wildcard_ssl_app = var.wildcard_ssl_app
  vpc_id = module.network.vpc_id
  app_listener_host_header = var.app_listener_host_header
  ecs_ec2_instance_name = var.ecs_ec2_instance_name
  ec2_ami_ecs_optimized = var.ec2_ami_ecs_optimized
  ecs_cluster_name = var.ecs_cluster_name
  ec2_key_pair = var.ec2_key_pair
}

module "storage" {
  source = "./modules/storage"

  iam_user_app = var.iam_user_app
  s3_bucket_app = var.s3_bucket_app
  policy_name_app= var.policy_name_app

  rds_password = var.rds_password
  rds_username = var.rds_username
  rds_instance_class = var.rds_instance_class
  rds_storage_type = var.rds_storage_type
  rds_vpc_security_group_ids = var.rds_vpc_security_group_ids
  rds_db_subnet_group_name = var.rds_db_subnet_group_name
  rds_engine_version = var.rds_engine_version
  rds_skip_final_snapshot = var.rds_skip_final_snapshot
  rds_backup_retention_period = var.rds_backup_retention_period
  rds_multi_az = var.rds_multi_az
  rds_publicly_accessible = var.rds_publicly_accessible
  rds_allocated_storage = var.rds_allocated_storage
  rds_engine = var.rds_engine
  rds_identifier = var.rds_identifier
}

module "web" {
  source = "./modules/web"

  amplify_app_name = var.amplify_app_name
}

module "domain" {
  source = "./modules/domain"

  app_domain_zone_id = var.app_domain_zone_id
  app_listener_host_header = var.app_listener_host_header
  alb_dns_name = module.servers.alb_dns_name
  alb_zone_id = module.servers.alb_zone_id
}

module "infra" {
  source = "./modules/infra"

  vpc_id = module.network.vpc_id
  infra_ami = var.infra_ami
  static_infra_private_ip = var.static_infra_private_ip
  subnet_id = module.network.app_subnet_1_id
  key_name = var.key_name
  redis_password = var.redis_password
}