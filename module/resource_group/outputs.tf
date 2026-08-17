output "rgs" {
  value = {
    for k, v in azurerm_resource_group.rgs : k => {
      id   = v.id
      name = v.name
    }
  }
  description = "Map of created Resource Groups"
}
