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

    environment = concat(
      var.env_var,
      ### ? Depends on the infra structure
      # [
      #   {
      #     name  = "DB_HOST"
      #     value = var.rds_db_host
      #   },
      #   {
      #     name  = "DB_PORT"
      #     value = var.rds_db_port
      #   },
      #   {
      #     name  = "DB_DATABASE"
      #     value = var.rds_db_database
      #   },
      #   {
      #     name  = "DB_USER"
      #     value = var.rds_db_user
      #   },
      #   {
      #     name  = "DB_PASSWORD"
      #     value = var.rds_db_password
      #   },
      #   {
      #     name = "AWS_ACCESS_KEY_ID"
      #     value = var.aws_access_key_id
      #   },
      #   {
      #     name = "AWS_SECRET_ACCESS_KEY"
      #     value = var.aws_secret_access_key
      #   },
      #   {
      #     name = "AWS_S3_BUCKET"
      #     value = var.aws_s3_bucket
      #   },
      # ]
    )

    ### ? Logging Configuration for fluentd, loki and grafana
    # logConfiguration = {
    #   logDriver = "fluentd"
    #   options = {
    #       "fluentd-address" = "localhost:24224"
    #       "tag" = "raptor-server-prod",
    #       "fluentd-async-connect" = "true"
    #   }
    # }
  }])

  depends_on = [ aws_ecs_cluster.app_ecs_cluster ]

  # lifecycle {
  #   ignore_changes = [
  #     container_definitions, #* Remove if there's changes under container definitions
  #   ]
  # }
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
    target_group_arn = var.app_tg_arn
    container_name = var.app_container_name
    container_port = 3333 # ? Depends on the APP_PORT
  }

  depends_on = [ var.app_tg_arn, aws_ecs_task_definition.app_taskdef, aws_ecs_cluster.app_ecs_cluster ]
}