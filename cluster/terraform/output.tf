output "inventory" {
  sensitive = true
  value = yamlencode({
    "all" : {
      children : {
        control = {},
        proxy   = {}
        agent   = {}
      }
    }
    "control" : {
      hosts : { for s in binarylane_server.control : s.name => {
        "ansible_host" : s.public_ipv4_addresses[0],
        "ansible_user" : "root"
        }
      }
    }

    "proxy" : {
      hosts : { for s in binarylane_server.proxy : s.name => {
        "ansible_host" : s.public_ipv4_addresses[0]
        "ansible_user" : "root"
        }
      }
    }

    "agent" : {
      hosts : { for s in binarylane_server.agent : s.name => {
        "ansible_host" : s.public_ipv4_addresses[0]
        "ansible_user" : "root"
        }
      }
    }
  })
}
