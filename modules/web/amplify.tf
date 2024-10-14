resource "aws_amplify_app" "app" {
  name = var.amplify_app_name
  repository = aws_amplify_branch.branch.repository_id
  environment_variables = {
    "KEY1" = "VALUE1"
    "KEY2" = "VALUE2"
  }
}

# resource "aws_amplify_app" "app" {
#   name          = var.app_name
#   repository    = aws_amplify_branch.branch.repository_id
# }
# Compare this snippet from modules/servers/main.tf:
# resource "aws_instance" "app" {
#   ami           = var.ec2_ami_ecs_optimized
#   instance_type = "t2.micro"
#   subnet_id     = var.app_subnet_1_id
#   tags = {
#     Name = var.app_name
#   }
# }

# resource "aws_instance" "app2" {
#   ami           = var.ec2_ami_ecs_optimized
#   instance_type = "t2.micro"
#   subnet_id     = var.app_subnet_2_id
#   tags = {
#     Name = "${var.app_name}2"
#   }
# }

# resource "aws_lb" "app" {
#   name               = var.app_name
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.app.id]
#   subnets            = [var.app_subnet_1_id, var.app_subnet_2_id]
# 
#   enable_deletion_protection = false
#   enable_cross_zone_load_balancing = true
#   enable_http2 = true
#   idle_timeout = 400
#   tags = {
#     Name = var.app_name
#   }
# }

# resource "aws_lb_listener" "app" {
#   load_balancer_arn = aws_lb.app.arn
#   port              = 80
#   protocol          = "HTTP"
# 
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.app.arn
#   }
# }

# resource "aws_lb_target_group" "app" {
#   name     = var.app_name
#   port     =