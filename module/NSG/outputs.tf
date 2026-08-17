output "nsgs" {
  value = {
    for k, v in azurerm_network_security_group.nsg : k => {
      id   = v.id
      name = v.name
    }
  }
  description = "Map of created Network Security Groups"
}
