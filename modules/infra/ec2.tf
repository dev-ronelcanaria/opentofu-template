resource "aws_instance" "ec2_app_infra" {
    ami = var.infra_ami
    instance_type = "t2.small"
    subnet_id = var.subnet_id
    vpc_security_group_ids = [aws_security_group.secgrp_app_infra.id]
    key_name = var.key_name
    private_ip = var.static_infra_private_ip

    ebs_block_device {
      device_name = "/dev/sda1"
      volume_size = "12"
      delete_on_termination = false
    }

    user_data = <<-EOF
      #!/bin/bash
      # Update and install packages
      sudo apt-get update -y
      sudo apt-get install -y redis-server
      
      sudo systemctl start redis-server
      sudo systemctl enable redis-server

      # Update Redis configuration to allow remote connections
      sudo sed -i "s/^bind .*/bind 0.0.0.0/" /etc/redis/redis.conf

      # Set password for Redis
      sudo sed -i "s/# requirepass foobared/requirepass ${var.redis_password}/" /etc/redis/redis.conf

      sudo sed -i "s/databases 16/databases 16/g" /etc/redis/redis.conf
      sudo systemctl restart redis-server
    EOF

    tags = {
        Name = "app-server-infra"
    }
}