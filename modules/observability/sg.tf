# Security Group
resource "aws_security_group" "logs_sg" {
  name = "secgrp-logs_monitoring"
  vpc_id = var.aws_vpc_id
  description = "Allow HTTP, HTTPS and Prometheus/Grafana access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block, var.ssh_cidr_my_ip]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  ingress {
    from_port   = 3100
    to_port     = 3100
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "secgrp-logs_monitoring"
  }
}