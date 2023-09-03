
resource "aws_security_group" "internal-sg" {
  name        = "internal-default-sg"
  description = "Default SG rules for internal apps"
  vpc_id      = aws_vpc.internal-vpc.id
}

resource "aws_vpc_security_group_egress_rule" "allow-all-external" {
  security_group_id = aws_security_group.internal-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_security_group" "internal-ssh-sg" {
  name        = "internal-ssh-sg"
  description = "SSH rules for internal apps"
  vpc_id      = aws_vpc.internal-vpc.id
}

module "home-ip-kv" {
  source      = "../module/keyvault-value-output"
  secret_name = "home-static-ip"
}

resource "aws_vpc_security_group_ingress_rule" "allow-ssh" {
  security_group_id = aws_security_group.internal-ssh-sg.id

  cidr_ipv4   = "${module.home-ip-kv.secret_value}/32"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_security_group" "internal-wireguard-sg" {
  name        = "internal-wireguard-sg"
  description = "Wireguard rules for internal apps"
  vpc_id      = aws_vpc.internal-vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow-wireguard" {
  security_group_id = aws_security_group.internal-wireguard-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 51820
  ip_protocol = "udp"
  to_port     = 51820
}

resource "aws_security_group" "internal-shared-applications-sg" {
  name        = "internal-shared-applications-sg"
  description = "shared-applications rules for internal apps"
  vpc_id      = aws_vpc.internal-vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow-shared-applications" {
  security_group_id = aws_security_group.internal-shared-applications-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_security_group" "internal-efs-sg" {
  name        = "internal-efs-sg"
  description = "Rules for EFS access"
  vpc_id      = aws_vpc.internal-vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow-nfs" {
  security_group_id = aws_security_group.internal-efs-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 2049
  ip_protocol = "tcp"
  to_port     = 2049
}
