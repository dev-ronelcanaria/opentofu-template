variable "aws_region" {
  type = string
}

variable "app_name" {
  type = string 
}

# VPC
  variable "vpc_name" {
    type = string
  }
  variable "vpc_cidr_block" {
    type = string
  }
  variable "vpc_subnet_1_name" {
    type = string
  }
  variable "vpc_subnet_1_cidr_block" {
    type = string
  }
  variable "vpc_subnet_1_availability_zone" {
    type = string
  }
  variable "vpc_subnet_2_name" {
    type = string
  }
  variable "vpc_subnet_2_cidr_block" {
    type = string
  }
  variable "vpc_subnet_2_availability_zone" {
    type = string
  }
  variable "vpc_igw" {
    type = string
  }
  variable "vpc_rtb_cidr_block" {
    type = string
  }

# ECR
  variable "app_ecr_name" {
    type = string
  }

# ECS
  variable "ecs_cluster_name" {
    type = string
  }
  variable "app_taskdef_family" {
    type = string
  }
  variable "app_container_name" {
    type = string
  }
  variable "app_ecs_service_name" {
    type = string
  }
  variable "wildcard_ssl_app" {
    type = string
  }
  variable "app_listener_host_header" {
    type = string
  }

# ASG
  variable "ecs_ec2_instance_name" {
    type = string
  }
  variable "ec2_ami_ecs_optimized" {
    type = string
  }

  variable "ec2_key_pair" {
    type = string
  }

# RDS
  variable "rds_password" {
    description = "The password for the RDS instance"
    type = string
  }
  variable "rds_username" {
    description = "The username for the RDS instance"
    type = string
  }
  variable "rds_instance_class" {
    description = "The instance class for the RDS instance"
    type = string
  }
  variable "rds_storage_type" {
    description = "The storage type for the RDS instance"
    type = string
  }
  variable "rds_vpc_security_group_ids" {
    description = "The VPC security group IDs for the RDS instance"
    type = list(string)
  }
  variable "rds_db_subnet_group_name" {
    description = "The DB subnet group name for the RDS instance"
    type = string
  }
  variable "rds_engine_version" {
    description = "The engine version for the RDS instance"
    type = string
  }
  variable "rds_skip_final_snapshot" {
    description = "Whether to skip the final snapshot when deleting the RDS instance"
    type = bool
  }
  variable "rds_backup_retention_period" {
    description = "The backup retention period for the RDS instance"
    type = number
  }
  variable "rds_multi_az" {
    description = "Whether the RDS instance is multi-AZ"
    type = bool
  }
  variable "rds_publicly_accessible" {
    description = "Whether the RDS instance is publicly accessible"
    type = bool
  }
  variable "rds_allocated_storage" {
    description = "The allocated storage for the RDS instance"
    type = number
  }
  variable "rds_engine" {
    description = "The engine type for the RDS instance"
    type = string
  }
  variable "rds_identifier" {
    description = "The identifier for the RDS instance"
    type = string
  }

# S3
  variable "iam_user_app" {
    type = string
  }
  variable "s3_bucket_app" {
    type = string
  }
  variable "policy_name_app" {
    type = string
  }

# Amplify
  variable "amplify_app_name" {
    description = "The name of the Amplify app"
    type = string
  }

# Domain
  variable "app_domain_zone_id" {
    description = "The Route 53 zone ID for the domain"
    type = string
  }
  
# Infra

  variable "infra_ami" {
    description = "The AMI ID to use for the EC2 instance"
    type = string
  }

  variable "static_infra_private_ip" {
    description = "The private IP address to assign to the EC2 instance"
    type = string
  }

  variable "subnet_id" {
    description = "The subnet IDs to use for the EC2 instance"
    type = string
  }

  variable "key_name" {
    description = "The key pair name to use for the EC2 instance"
    type = string
  }

  variable "redis_password" {
    description = "The password to use for the Redis server"
    type = string
  }