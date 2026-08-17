output "vms" {
  value = {
    for k, v in azurerm_linux_virtual_machine.vms : k => {
      id   = v.id
      name = v.name
    }
  }
  description = "Map of created Virtual Machines"
}

output "nics" {
  value = {
    for k, v in azurerm_network_interface.nic : k => {
      id   = v.id
      name = v.name
    }
  }
  description = "Map of created Network Interfaces"
}
