resource "aws_autoscaling_group" "asg_app" {
  name = "asg-${var.app_name}"
  min_size = 1
  max_size = 3
  desired_capacity = 1
  vpc_zone_identifier  = [var.app_subnet_1_id, var.app_subnet_2_id]
  health_check_type = "EC2"

  launch_template {
    id = aws_launch_template.launch_template_app.id
    version = "$Latest"
  }

  tag {
    key = "Name"
    value = var.ecs_ec2_instance_name
    propagate_at_launch = true
  }
}

resource "aws_launch_template" "launch_template_app" {
  name = "launch-template-${var.app_name}"
  default_version = 1 # always +1 when there's changes on template
  image_id = var.ec2_ami_ecs_optimized
  instance_type = "t2.micro"
  key_name = aws_key_pair.key_pair_app.key_name
  user_data = base64encode(
    <<-EOF
      #!/bin/bash

      # Update and install Docker
      sudo dnf update -y
      sudo dnf install -y docker
      sudo systemctl start docker
      sudo usermod -a -G docker ec2-user

      # Set ECS cluster name and install ECS agent
      echo ECS_CLUSTER=${var.ecs_cluster_name} >> /etc/ecs/ecs.config
      sudo dnf install -y amazon-ecs-agent

      # Install Ruby
      sudo dnf groupinstall -y "Development Tools"
      sudo dnf install -y ruby ruby-devel

      # Install Fluentd
      # sudo gem install fluentd --no-doc
      # sudo fluent-gem install fluent-plugin-grafana-loki

      # Create Fluentd configuration directory
      # sudo mkdir -p /etc/fluentd

      # Write Fluentd configuration file
      # cat <<EOL | sudo tee /etc/fluentd/fluentd.conf
      # <source>
      #     @type forward
      #     port 24224
      #     bind 0.0.0.0
      # </source>

      # <filter app-**>
      #   @type record_transformer
      #   <record>
      #     environment
      #   </record>
      # </filter>

      # <match app>
      #   @type loki
      #   url "http://<grafana-ip>:3100"
      #   extra_labels {"agent": "fluentd", "server": "app"}
      #   <buffer>
      #     flush_interval 5s
      #     flush_at_shutdown true
      #     chunk_limit_size 1m
      #   </buffer>
      # </match>
      # EOL

      # Create a systemd service for Fluentd
      # cat <<EOL | sudo tee /etc/systemd/system/fluentd.service
      # [Unit]
      # Description=Fluentd logs collector
      # After=network.target

      # [Service]
      # ExecStart=/usr/local/bin/fluentd -c /etc/fluentd/fluentd.conf
      # Restart=always
      # User=root
      # Group=root

      # [Install]
      # WantedBy=multi-user.target
      # EOL

      # Reload systemd, start and enable Fluentd service
      # sudo systemctl daemon-reload
      # sudo systemctl start fluentd
      # sudo systemctl enable fluentd
    EOF
  )

  vpc_security_group_ids = [aws_security_group.ecs_security_group.id]

  iam_instance_profile {
      arn = aws_iam_instance_profile.ec2_instance_role_profile.arn
  }

  # lifecycle {
  #   ignore_changes = [
  #     default_version
  #   ]
  # }
}
