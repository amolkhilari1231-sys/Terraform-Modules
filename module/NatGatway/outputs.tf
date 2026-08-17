output "natgw" {
  value = {
    for k, v in azurerm_nat_gateway.natgw : k => {
      id   = v.id
      name = v.name
    }
  }
  description = "Map of created NAT Gateways"
}
