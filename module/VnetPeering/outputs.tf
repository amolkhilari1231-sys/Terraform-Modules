output "peerings" {
  value = {
    for k, v in azurerm_virtual_network_peering.peering : k => {
      id   = v.id
      name = v.name
    }
  }
  description = "Map of created VNet Peerings"
}
