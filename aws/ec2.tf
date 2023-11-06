resource "aws_instance" "worker" {
  # amazon linux 2023 ecs
  ami                         = "ami-0131729fe2781f22c"
  instance_type               = "t3a.small"
  user_data_replace_on_change = true
  iam_instance_profile        = aws_iam_instance_profile.ecs-agent.name
  user_data                   = <<EOT
#!/bin/bash
cat <<'EOF' >> /etc/ecs/ecs.config
ECS_CLUSTER=${aws_ecs_cluster.this.name}
EOF
EOT

  network_interface {
    network_interface_id = aws_network_interface.worker-internal.id
    device_index         = 0
  }

  key_name = aws_key_pair.local.key_name

  tags = {
    Name = "ecs-worker"
  }
}

resource "aws_key_pair" "local" {
  key_name   = "worker-local-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKuIXS2XvWQ6kXXzvRmlRkf6gMEcapcQTSf/dBRtGLU2 server@anurag.sh"
}

resource "aws_network_interface" "worker-internal" {
  subnet_id = aws_subnet.internal-subnet-syda.id
  security_groups = [
    aws_security_group.internal-sg.id,
    aws_security_group.internal-wireguard-sg.id,
    aws_security_group.internal-ssh-sg.id,
    aws_security_group.internal-shared-applications-sg.id,
  ]

  source_dest_check = false

  tags = {
    Name = "worker-internal-interface"
  }
}

resource "aws_eip" "worker-eip" {
  network_interface = aws_network_interface.worker-internal.id

  tags = {
    Name = "worker-static-ip"
  }

  depends_on = [aws_internet_gateway.internal-gw]
}
