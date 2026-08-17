resource "azurerm_network_security_group" "nsg" {
  for_each            = var.nsgs
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  dynamic "security_rule" {
    for_each = lookup(each.value, "rules", [])
    content {
      name                         = security_rule.value.name
      priority                     = security_rule.value.priority
      direction                    = security_rule.value.direction
      access                       = security_rule.value.access
      protocol                     = security_rule.value.protocol
      source_port_range            = lookup(security_rule.value, "source_port_range", "*")
      destination_port_range       = lookup(security_rule.value, "destination_port_range", "*")
      destination_port_ranges      = lookup(security_rule.value, "destination_port_ranges", null)
      source_address_prefix        = lookup(security_rule.value, "source_address_prefix", "*")
      source_address_prefixes      = lookup(security_rule.value, "source_address_prefixes", null)
      destination_address_prefix   = lookup(security_rule.value, "destination_address_prefix", "*")
      destination_address_prefixes = lookup(security_rule.value, "destination_address_prefixes", null)
    }
  }
}

data "azurerm_subnet" "associated_subnets" {
  for_each = {
    for k, v in var.nsgs : k => v
    if lookup(v, "subnet_name", null) != null && lookup(v, "subnet_id", null) == null
  }
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  for_each = {
    for k, v in var.nsgs : k => v
    if lookup(v, "subnet_name", null) != null || lookup(v, "subnet_id", null) != null
  }
  subnet_id                 = lookup(each.value, "subnet_id", null) != null ? each.value.subnet_id : data.azurerm_subnet.associated_subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}
