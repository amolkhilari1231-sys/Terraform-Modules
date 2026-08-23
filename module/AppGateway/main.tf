data "azurerm_subnet" "appgw_subnet" {
  for_each = {
    for k, v in var.app_gateways : k => v
    if lookup(v, "subnet_name", null) != null && lookup(v, "subnet_key", null) == null && lookup(v, "subnet_id", null) == null
  }
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}

data "azurerm_public_ip" "appgw_pip" {
  for_each = {
    for k, v in var.app_gateways : k => v
    if lookup(v, "pip_name", null) != null && lookup(v, "pip_key", null) == null && lookup(v, "pip_id", null) == null
  }
  name                = each.value.pip_name
  resource_group_name = each.value.rg_name
}

resource "azurerm_application_gateway" "appgw" {
  for_each            = var.app_gateways
  name                = each.value.name
  resource_group_name = each.value.rg_name
  location            = each.value.location
  http2_enabled       = lookup(each.value, "http2_enabled", true)

  sku {
    name     = lookup(each.value, "sku_name", "Standard_v2")
    tier     = lookup(each.value, "sku_tier", "Standard_v2")
    capacity = lookup(each.value, "capacity", 2)
  }

  gateway_ip_configuration {
    name      = "${each.value.name}-ip-config"
    subnet_id = lookup(each.value, "subnet_id", null) != null ? each.value.subnet_id : try(data.azurerm_subnet.appgw_subnet[each.key].id, null)
  }

  frontend_port {
    name = "${each.value.name}-frontend-port"
    port = lookup(each.value, "frontend_port", 80)
  }

  frontend_ip_configuration {
    name                 = "${each.value.name}-frontend-ip"
    public_ip_address_id = lookup(each.value, "pip_id", null) != null ? each.value.pip_id : try(data.azurerm_public_ip.appgw_pip[each.key].id, null)
  }

  backend_address_pool {
    name         = "${each.value.name}-backend-pool"
    ip_addresses = lookup(each.value, "backend_ip_addresses", [])
  }

  backend_http_settings {
    name                  = "${each.value.name}-backend-http-settings"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = lookup(each.value, "backend_port", 80)
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "${each.value.name}-http-listener"
    frontend_ip_configuration_name = "${each.value.name}-frontend-ip"
    frontend_port_name             = "${each.value.name}-frontend-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${each.value.name}-routing-rule"
    rule_type                  = "Basic"
    priority                   = 1
    http_listener_name         = "${each.value.name}-http-listener"
    backend_address_pool_name  = "${each.value.name}-backend-pool"
    backend_http_settings_name = "${each.value.name}-backend-http-settings"
  }
}
