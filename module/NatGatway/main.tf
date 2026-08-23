resource "azurerm_nat_gateway" "natgw" {
  for_each                = var.natgw
  name                    = each.value.name
  location                = each.value.location
  resource_group_name     = each.value.resource_group_name
  sku_name                = lookup(each.value, "sku_name", "Standard")
  idle_timeout_in_minutes = lookup(each.value, "idle_timeout_in_minutes", 10)
  zones                   = lookup(each.value, "zones", null)
}

data "azurerm_public_ip" "natgw_pip" {
  for_each = {
    for k, v in var.natgw : k => v
    if lookup(v, "pip_name", null) != null && lookup(v, "pip_key", null) == null && lookup(v, "pip_id", null) == null
  }
  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_nat_gateway_public_ip_association" "pip_assoc" {
  for_each = {
    for k, v in var.natgw : k => v
    if lookup(v, "pip_key", null) != null || lookup(v, "pip_name", null) != null || lookup(v, "pip_id", null) != null
  }
  nat_gateway_id       = azurerm_nat_gateway.natgw[each.key].id
  public_ip_address_id = lookup(each.value, "pip_id", null) != null ? each.value.pip_id : try(data.azurerm_public_ip.natgw_pip[each.key].id, null)
}

data "azurerm_subnet" "natgw_subnet" {
  for_each = {
    for k, v in var.natgw : k => v
    if lookup(v, "subnet_name", null) != null && lookup(v, "subnet_key", null) == null && lookup(v, "subnet_id", null) == null
  }
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}

resource "azurerm_subnet_nat_gateway_association" "subnet_assoc" {
  for_each = {
    for k, v in var.natgw : k => v
    if lookup(v, "subnet_key", null) != null || lookup(v, "subnet_name", null) != null || lookup(v, "subnet_id", null) != null
  }
  subnet_id      = lookup(each.value, "subnet_id", null) != null ? each.value.subnet_id : try(data.azurerm_subnet.natgw_subnet[each.key].id, null)
  nat_gateway_id = azurerm_nat_gateway.natgw[each.key].id
}
