output "appgw" {
  value = {
    for k, v in azurerm_application_gateway.appgw : k => {
      id   = v.id
      name = v.name
    }
  }
  description = "Map of created Application Gateways"
}
