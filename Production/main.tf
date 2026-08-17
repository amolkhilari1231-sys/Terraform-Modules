module "resource_group" {
  source = "../module/resource_group"
  rgs    = var.rgs
}

module "virtual_network" {
  source     = "../module/Virtual_network"
  vnets      = var.vnets
  depends_on = [module.resource_group]
}

module "subnet" {
  source     = "../module/Subnets"
  subnets    = var.subnets
  depends_on = [module.virtual_network]
}

module "pip" {
  source     = "../module/Public_ip"
  pips       = var.pips
  depends_on = [module.resource_group]
}

module "vnet_peering" {
  source = "../module/VnetPeering"
  peerings = {
    for k, v in var.peerings : k => merge(v, {
      remote_vnet_id = lookup(v, "remote_vnet_key", null) != null ? module.virtual_network.vnets[v.remote_vnet_key].id : null
    })
  }
  depends_on = [module.virtual_network]
}

module "nsg" {
  source = "../module/NSG"
  nsgs = {
    for k, v in var.nsgs : k => merge(v, {
      subnet_id = lookup(v, "subnet_key", null) != null ? module.subnet.subnets[v.subnet_key].id : null
    })
  }
  depends_on = [module.subnet]
}

module "nat_gateways" {
  source = "../module/NatGatway"
  natgw = {
    for k, v in var.natgw : k => merge(v, {
      pip_id    = lookup(v, "pip_key", null) != null ? module.pip.pips[v.pip_key].id : null
      subnet_id = lookup(v, "subnet_key", null) != null ? module.subnet.subnets[v.subnet_key].id : null
    })
  }
  depends_on = [module.subnet, module.pip]
}

module "app_gateway" {
  source = "../module/AppGateway"
  app_gateways = {
    for k, v in var.app_gateways : k => merge(v, {
      subnet_id = lookup(v, "subnet_key", null) != null ? module.subnet.subnets[v.subnet_key].id : null
      pip_id    = lookup(v, "pip_key", null) != null ? module.pip.pips[v.pip_key].id : null
    })
  }
  depends_on = [module.subnet, module.pip]
}

module "bastion" {
  source = "../module/Bastion"
  bastions = {
    for k, v in var.bastions : k => merge(v, {
      subnet_id = lookup(v, "subnet_key", null) != null ? module.subnet.subnets[v.subnet_key].id : null
      pip_id    = lookup(v, "pip_key", null) != null ? module.pip.pips[v.pip_key].id : null
    })
  }
  depends_on = [module.subnet, module.pip]
}

module "vm" {
  source = "../module/Virtual_machine"
  vms = {
    for k, v in var.vms : k => merge(v, {
      subnet_id = lookup(v, "subnet_key", null) != null ? module.subnet.subnets[v.subnet_key].id : null
    })
  }
  depends_on = [module.subnet, module.pip, module.nsg]
}

module "storage_account" {
  source          = "../module/Storage_account"
  storage_account = var.storage_account
  depends_on      = [module.resource_group]
}