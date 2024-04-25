data "aws_efs_file_system" "data" {
  file_system_id = "fs-05ef75ae56cb6e2f6"
}

resource "aws_efs_access_point" "uptime-data" {
  file_system_id = data.aws_efs_file_system.data.id
  posix_user {
    gid = 0
    uid = 0
  }

  root_directory {
    creation_info {
      owner_gid   = 0
      owner_uid   = 0
      permissions = "777"
    }
    path = "/uptime"
  }

  tags = {
    Name = "Uptime Data"
  }
}


resource "aws_efs_access_point" "uptime-data-v2" {
  file_system_id = data.aws_efs_file_system.data.id
  posix_user {
    gid = 0
    uid = 0
  }

  root_directory {
    creation_info {
      owner_gid   = 0
      owner_uid   = 0
      permissions = "777"
    }
    path = "/uptime-data-v2"
  }

  tags = {
    Name = "Uptime Data V2"
  }
}
