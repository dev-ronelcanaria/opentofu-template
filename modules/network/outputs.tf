output "app_subnet_1_id" {
  value = aws_subnet.app_subnet_1.id
}

output "app_subnet_2_id" {
  value = aws_subnet.app_subnet_2.id
}

output "vpc_id" {
  value = aws_vpc.app_vpc.id
}