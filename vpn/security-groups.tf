
data "aws_security_group" "internal-sg" {
  id = "sg-0e8b5f765739d0864"
}

data "aws_security_group" "internal-wireguard-sg" {
  id = "sg-075ac12eb01310c30"
}
