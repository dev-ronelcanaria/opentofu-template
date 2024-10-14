resource "aws_ecs_cluster" "app_ecs_cluster" {
  name = var.ecs_cluster_name
}

/*
  For multiple service, just copy the aws_ecs_task_definition and aws_ecs_service.
  Make sure to duplicate the aws_ecr_repository on the ecr.tf
*/

resource "aws_ecs_task_definition" "app_taskdef" {
  family = var.app_taskdef_family
  network_mode = "bridge"
  requires_compatibilities = ["EC2"]
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name  = var.app_container_name
    image = "${aws_ecr_repository.app_ecr.repository_url}:latest"
    essential = true
    cpu = 0
    memoryReservation = 150
    portMappings = [{
      containerPort = 3333 # ? Depends on the APP_PORT
      hostPort = 0
      protocol = "tcp"
    }]
  }])
}

resource "aws_ecs_service" "app_ecs_service" {
  name = var.app_ecs_service_name
  cluster = aws_ecs_cluster.app_ecs_cluster.id
  task_definition = aws_ecs_task_definition.app_taskdef.arn
  desired_count = 1

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent = 200

  force_new_deployment = true
  
  load_balancer {
    target_group_arn = aws_lb_target_group.app_tg.arn
    container_name = var.app_container_name
    container_port = 3333 # ? Depends on the APP_PORT
  }
}