output "inventory" {
  sensitive = true
  value = yamlencode({
    "all" : {
      children : {
        control = {},
        worker  = {},
        proxy   = {}
        agent   = {}
      }
    }
    "control" : {
      hosts : { for s in binarylane_server.control : s.name => {
        "ansible_host" : s.public_ipv4_addresses[0]
        }
      }
    }

    "proxy" : {
      hosts : { for s in binarylane_server.proxy : s.name => {
        "ansible_host" : s.public_ipv4_addresses[0]
        }
      }
    }

    "worker" : {
      hosts : { for s in binarylane_server.worker : s.name => {
        "ansible_host" : s.public_ipv4_addresses[0]
        }
      }
    }

    "agent" : {
      hosts : { for s in binarylane_server.agent : s.name => {
        "ansible_host" : s.public_ipv4_addresses[0]
        }
      }
    }
  })
}
