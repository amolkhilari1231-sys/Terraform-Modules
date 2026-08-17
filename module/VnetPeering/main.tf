data "azurerm_virtual_network" "src_vnet" {
  for_each = {
    for k, v in var.peerings : k => v
    if lookup(v, "src_vnet_id", null) == null
  }
  name                = each.value.src_vnet_name
  resource_group_name = each.value.src_rg_name
}

data "azurerm_virtual_network" "remote_vnet" {
  for_each = {
    for k, v in var.peerings : k => v
    if lookup(v, "remote_vnet_id", null) == null
  }
  name                = each.value.remote_vnet_name
  resource_group_name = each.value.remote_rg_name
}

resource "azurerm_virtual_network_peering" "peering" {
  for_each                     = var.peerings
  name                         = each.value.name
  resource_group_name          = each.value.src_rg_name
  virtual_network_name         = lookup(each.value, "src_vnet_name", null) != null ? each.value.src_vnet_name : data.azurerm_virtual_network.src_vnet[each.key].name
  remote_virtual_network_id    = lookup(each.value, "remote_vnet_id", null) != null ? each.value.remote_vnet_id : data.azurerm_virtual_network.remote_vnet[each.key].id
  allow_virtual_network_access = lookup(each.value, "allow_virtual_network_access", true)
  allow_forwarded_traffic      = lookup(each.value, "allow_forwarded_traffic", true)
  allow_gateway_transit        = lookup(each.value, "allow_gateway_transit", false)
  use_remote_gateways          = lookup(each.value, "use_remote_gateways", false)
}
