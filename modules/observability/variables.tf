variable "observability_ami_id" {
  description = "The AMI ID for the observability instance"
  type = string
}

variable "observability_instance_type" {
  description = "The instance type for the observability instance"
  type = string
}

variable "observability_subnet_id" {
  description = "The subnet ID for the observability instance"
  type = string
}

variable "observability_key_name" {
  description = "The key name for the observability instance"
  type = string
}

variable "aws_vpc_id" {
  description = "The VPC ID for the observability instance"
  type = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type = string
}

variable "ssh_cidr_my_ip" {
  description = "The CIDR block for the SSH connection"
  type = string
}