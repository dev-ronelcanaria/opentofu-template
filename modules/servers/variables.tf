variable "app_name" {
  type = string
}

variable "app_subnet_1_id" {
  type = string
}

variable "app_subnet_2_id" {
  type = string
}

variable "wildcard_ssl_app" {
  type = string
}

variable "vpc_id" {
  type = string  
}

variable "app_listener_host_header" {
  type = string
}

variable "ecs_ec2_instance_name" {
  type = string
}

variable "ec2_ami_ecs_optimized" {
  type = string
}

variable "ecs_cluster_name" {
  type = string
}

variable "ec2_key_pair" {
  type = string
}