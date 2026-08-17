output "subnets" {
  value = {
    for k, v in azurerm_subnet.subnets : k => {
      id   = v.id
      name = v.name
    }
  }
  description = "Map of created Subnets"
}
