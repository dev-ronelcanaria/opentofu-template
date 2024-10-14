resource "aws_ecr_repository" "app_ecr" {
  name = var.app_ecr_name
}