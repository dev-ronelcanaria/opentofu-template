variable "vpc_id" {
  description = "The VPC ID to use for the EC2 instance"
  type = string
}

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