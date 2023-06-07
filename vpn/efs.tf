data "aws_efs_file_system" "data" {
  file_system_id = "fs-05ef75ae56cb6e2f6"
}

resource "aws_efs_access_point" "vpn-data" {
  file_system_id = data.aws_efs_file_system.data.id
  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory {
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "777"
    }
    path = "/vpn"
  }

  tags = {
    Name = "VPN Data"
  }
}
