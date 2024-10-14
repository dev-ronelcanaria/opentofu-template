resource "aws_alb" "alb_app" {
  name = "alb-${var.app_name}"
  security_groups = [aws_security_group.alb_app_security_group.id]
  subnets = [var.app_subnet_1_id, var.app_subnet_2_id]

  tags = {
    Name = "alb-${var.app_name}"
  }
}

resource "aws_alb_listener" "listener_app" {
  load_balancer_arn = aws_alb.alb_app.arn
  port = 443
  protocol = "HTTPS"

  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.wildcard_ssl_app

  # port = 80
  # protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.tg_alb_app.arn
  }
}

resource "aws_alb_target_group" "tg_alb_app" {
  name = "tg-alb-${var.app_name}"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id

  /*
    health_check is only for non listener rule, 
    if directly use target group to an ECS or EC2, 
    then use health_check here

    health_check {
      path = "/health"
      interval = 60
      timeout = 5
      healthy_threshold = 3
      unhealthy_threshold = 5
      protocol = "HTTP"
    }
  */

  target_type = "instance"

  tags = {
    Name = "tg-alb-${var.app_name}"
  }
}

# Listener Rule

resource "aws_alb_target_group" "tg_app" {
  name = "tg-${var.app_name}"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    path = "/health" # Depends on app health check
    interval = 60
    timeout = 5
    healthy_threshold = 3
    unhealthy_threshold = 5
    protocol = "HTTP"
  }

  target_type = "instance"

  tags = {
    Name = "tg-${var.app_name}"
  }
}

resource "aws_alb_listener_rule" "listener_rule_app" {
  listener_arn = aws_alb_listener.listener_app.arn

  action {
    type = "forward"
    target_group_arn = aws_alb_target_group.tg_app.arn
  }

  condition {
    host_header {
      values = [var.app_listener_host_header]
    }
  }
}