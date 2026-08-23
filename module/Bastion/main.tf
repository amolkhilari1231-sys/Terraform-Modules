data "azurerm_subnet" "bastion_subnet" {
  for_each = {
    for k, v in var.bastions : k => v
    if lookup(v, "subnet_name", null) != null && lookup(v, "subnet_key", null) == null && lookup(v, "subnet_id", null) == null
  }
  name                 = lookup(each.value, "subnet_name", "AzureBastionSubnet")
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}

data "azurerm_public_ip" "bastion_pip" {
  for_each = {
    for k, v in var.bastions : k => v
    if lookup(v, "pip_name", null) != null && lookup(v, "pip_key", null) == null && lookup(v, "pip_id", null) == null
  }
  name                = each.value.pip_name
  resource_group_name = each.value.rg_name
}

resource "azurerm_bastion_host" "bastion" {
  for_each            = var.bastions
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.rg_name
  sku                 = lookup(each.value, "sku", "Standard")

  ip_configuration {
    name                 = "bastion-ip-config"
    subnet_id            = lookup(each.value, "subnet_id", null) != null ? each.value.subnet_id : try(data.azurerm_subnet.bastion_subnet[each.key].id, null)
    public_ip_address_id = lookup(each.value, "pip_id", null) != null ? each.value.pip_id : try(data.azurerm_public_ip.bastion_pip[each.key].id, null)
  }
}
