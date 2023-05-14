resource "null_resource" "setup-machines" {
  triggers = {
    syd    = fly_machine.this["syd"].id
    sin    = fly_machine.this["sin"].id
    script = filesha1("./config/scripts/fly-machines.sh")
  }

  depends_on = [fly_machine.this]

  provisioner "local-exec" {
    environment = {
      "FLY_MACHINE_ID_SYD" = fly_machine.this["syd"].id
      "FLY_MACHINE_ID_SIN" = fly_machine.this["sin"].id
    }

    command = "cd ./config && ./scripts/fly-machines.sh"
  }
}


resource "null_resource" "setup-secret" {
  triggers = {
    secret = random_password.redis-password.result
    script = filesha1("./config/scripts/fly-secrets.sh")
  }

  depends_on = [null_resource.setup-machines]

  provisioner "local-exec" {
    environment = {
      "REDIS_PASSWORD" = random_password.redis-password.result
    }

    command = "cd ./config && ./scripts/fly-secrets.sh"
  }
}

resource "null_resource" "deploy" {
  triggers = {
    dockerfile   = filesha1("./config/Dockerfile")
    fly-config   = filesha1("./config/fly.toml")
    redis-config = filesha1("./config/redis.conf")
    redis-script = filesha1("./config/start-redis-server.sh")
    script       = filesha1("./config/scripts/fly-deploy.sh")
    secret       = random_password.redis-password.result
  }

  depends_on = [null_resource.setup-machines, null_resource.setup-secret]

  provisioner "local-exec" {
    command = "cd ./config && ./scripts/fly-deploy.sh"
  }
}
