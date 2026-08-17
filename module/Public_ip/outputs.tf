output "pips" {
  value = {
    for k, v in azurerm_public_ip.pips : k => {
      id         = v.id
      name       = v.name
      ip_address = v.ip_address
    }
  }
  description = "Map of created Public IPs"
}
