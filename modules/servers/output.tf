output "app_tg_arn" {
  value = aws_alb_target_group.tg_app.arn
}

output "app_key_name" {
  value = aws_key_pair.ec2_key_pair.key_name
}

output "alb_dns_name" {
  value = aws_alb.alb_app.dns_name
}

output "alb_zone_id" {
  value = aws_alb.alb_app.zone_id
}

output "asg_app_name" {
  value = aws_autoscaling_group.asg_app.name
}

output "aws_alb_alb_app_arn_suffix" {
  value = aws_alb.alb_app.arn_suffix  
}

output "aws_alb_target_group_tg_app_arn_suffix" {
  value = aws_alb_target_group.tg_app.arn_suffix
}