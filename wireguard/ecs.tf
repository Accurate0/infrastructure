data "aws_ecs_cluster" "this" {
  cluster_name = "default-cluster"
}

resource "aws_ecs_task_definition" "this" {
  family       = "vpn-task"
  network_mode = "bridge"
  container_definitions = jsonencode(
    [
      {
        name              = "vpn",
        image             = "lscr.io/linuxserver/wireguard:latest",
        essential         = true,
        memoryReservation = 128,
        cpu               = 256,
        portMappings = [{
          hostPort      = 51820
          containerPort = 51820
          protocol      = "udp"
        }]
        linuxParameters = {
          capabilities = {
            add = ["NET_ADMIN", "SYS_MODULE"]
          },
          systemControls = [{
            namespace = "net.ipv4.conf.all.src_valid_mark",
            value     = "1"
          }]
        },
        mountPoints = [
          {
            containerPath = "/config",
            sourceVolume  = "VPN-Data"
          }
        ],
        logConfiguration = {
          logDriver = "awslogs",
          options = {
            awslogs-group         = "${aws_cloudwatch_log_group.vpn-log.name}",
            awslogs-region        = "ap-southeast-2",
            awslogs-stream-prefix = "ecs"
          }
        },
        environment = [
          {
            name  = "PUID"
            value = "1000"
          },
          {
            name  = "GUID"
            value = "1000"
          },
          {
            name  = "SERVERURL"
            value = "vpn.anurag.sh"
          },
          {
            name  = "SERVERPORT"
            value = "51820"
          },
          {
            name  = "LOG_CONFS"
            value = "false"
          },
          {
            name  = "PEERS"
            value = "phone,desktop"
          },
          {
            name  = "PEERDNS"
            value = "1.1.1.1"
          },
        ]
      }
    ]
  )

  volume {
    name = "VPN-Data"
    efs_volume_configuration {
      file_system_id     = data.aws_efs_file_system.data.id
      transit_encryption = "ENABLED"
      authorization_config {
        access_point_id = aws_efs_access_point.vpn-data.id
        iam             = "ENABLED"
      }
    }
  }

  requires_compatibilities = ["EC2"]
  execution_role_arn       = aws_iam_role.ecs-task-execution-role.arn
  task_role_arn            = aws_iam_role.ecs-container-iam-role.arn

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ecs_service" "this" {
  name                               = "vpn-service"
  cluster                            = data.aws_ecs_cluster.this.id
  task_definition                    = aws_ecs_task_definition.this.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100
}
