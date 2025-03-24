variable "app_ecr_name" {
  type = string
}

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

variable "env_var" {
  type = list(object({
    name  = string
    value = string
  }))
}

variable "app_tg_arn" {
  type = string
}