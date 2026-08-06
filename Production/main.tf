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

module "vm" {
  source     = "../module/Virtual_machine"
  vms        = var.vms
  depends_on = [module.subnet, module.pip]
}

module "nat_gateways" {
  source     = "../module/NatGatway"
  natgw      = var.natgw
  depends_on = [module.subnet]

}