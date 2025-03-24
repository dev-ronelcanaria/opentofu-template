resource "aws_instance" "observability_instance" {
  ami = var.observability_ami_id
  instance_type = var.observability_instance_type
  subnet_id = var.observability_subnet_id
  vpc_security_group_ids = [aws_security_group.logs_sg.id]
  key_name = var.observability_key_name
  private_ip = aws_eip.observability_eip.private_ip
  iam_instance_profile = aws_iam_instance_profile.observability_instance_profile.name

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = "8"
    delete_on_termination = false
  }

  user_data =<<-EOF
    #!/bin/bash
    # Update and install required packages
    sudo apt-get update
    sudo apt-get install -y apt-transport-https software-properties-common wget curl

    ### Install Docker
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install -y ca-certificates
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Post-docker Installation
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker

    ### Loki Setup
    mkdir loki
    cd loki

    # Create Loki configuration
    sudo mkdir -p ~/config/loki
    cat <<EOC | sudo tee ~/config/loki/loki-config.yaml
    auth_enabled: false

    server:
      http_listen_port: 3100
      grpc_listen_port: 9096

    common:
      instance_addr: 127.0.0.1
      path_prefix: /tmp/loki
      storage:
        filesystem:
        chunks_directory: /tmp/loki/chunks
        rules_directory: /tmp/loki/rules
      replication_factor: 1
      ring:
        kvstore:
        store: inmemory

    query_range:
      results_cache:
        cache:
          embedded_cache:
            enabled: true
            max_size_mb: 100

    schema_config:
      configs:
        - from: 2020-10-24
          store: tsdb
          object_store: filesystem
          schema: v11
          index:
            prefix: index_
            period: 24h

    ruler:
      alertmanager_url: http://localhost:9093

    EOC

    ### Run Thor =)
    docker run --name loki -d -v ~/config:/mnt/config -p 3100:3100 grafana/loki:3.0.0 -config.file=/mnt/config/loki/loki-config.yaml

    # Install Grafana
    sudo mkdir -p /etc/apt/keyrings/
    wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
    echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
    sudo apt-get update
    sudo apt-get install -y grafana
    sudo systemctl start grafana-server
    sudo systemctl enable grafana-server
  EOF

  tags = {
    Name = "app-monitoring"
  }

  lifecycle {
    ignore_changes = [
        user_data,
    ]
  }
}

# resource "aws_eip" "observability_eip" {
#   tags = {
#     Name = "app-observability-eip"
#   }
# }