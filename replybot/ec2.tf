resource "aws_spot_instance_request" "worker" {
  ami                         = "ami-039894e835f6017fd"
  instance_type               = "t2.micro"
  user_data_replace_on_change = true
  iam_instance_profile        = aws_iam_instance_profile.ecs-agent.name
  user_data                   = <<EOT
#!/bin/bash
cat <<'EOF' >> /etc/ecs/ecs.config
ECS_CLUSTER=${aws_ecs_cluster.this.name}
ECS_ENABLE_SPOT_INSTANCE_DRAINING=true
EOF
EOT
}
