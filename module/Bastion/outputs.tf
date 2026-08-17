output "bastions" {
  value = {
    for k, v in azurerm_bastion_host.bastion : k => {
      id   = v.id
      name = v.name
    }
  }
  description = "Map of created Azure Bastion Hosts"
}
