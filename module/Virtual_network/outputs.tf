output "vnets" {
  value = {
    for k, v in azurerm_virtual_network.vnet : k => {
      id   = v.id
      name = v.name
    }
  }
  description = "Map of created Virtual Networks"
}
