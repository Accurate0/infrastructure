output "inventory" {
  sensitive = true
  value = yamlencode({
    "all" : {
      children : {
        control = {},
        worker  = {},
        proxy   = {}
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
  })
}
