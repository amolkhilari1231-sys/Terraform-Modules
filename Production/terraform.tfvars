rgs = {
  rg1 = {
    name     = "rg_prod"
    location = "centralindia"
  }
   rg2 = {
    name     = "rg_preprod"
    location = "centralindia"
  }
   rg3 = {
    name     = "rg_dev"
    location = "centralindia"
  }
}

vnets = {
  vnet1 = {
    name                = "prod_vnet"
    location            = "centralindia"
    resource_group_name = "rg_prod"
    address_space       = ["10.0.0.0/16"]
  }
  vnet2 = {
    name                = "prod_vnet"
    location            = "centralindia"
    resource_group_name = "rg_preprod"
    address_space       = ["10.1.0.0/16"]
  }
}
subnets = {
  subnet1 = {
    name             = "frontend_subnet"
    vnet_name        = "prod_vnet"
    rg_name          = "rg_prod"
    address_prefixes = ["10.0.1.0/24"]
  }
  subnet2 = {
    name             = "backend_subnet"
    vnet_name        = "prod_vnet"
    rg_name          = "rg_prod"
    address_prefixes = ["10.0.2.0/24"]
  }

  subnet3 = {
    name             = "database_subnet"
    vnet_name        = "prod_vnet"
    rg_name          = "rg_prod"
    address_prefixes = ["10.0.3.0/24"]
  }
  subnet4 = {
    name             = "AzureBastionSubnet"
    vnet_name        = "prod_vnet"
    rg_name          = "rg_prod"
    address_prefixes = ["10.0.4.0/24"]
  }
  subnet5 = {
    name             = "AzureBastionSubnet"
    vnet_name        = "prod_vnet"
    rg_name          = "rg_preprod"
    address_prefixes = ["10.1.4.0/24"]
  }



}

pips = {
  pip1 = {
    name              = "fronend_pip"
    rg_name           = "rg_prod"
    location          = "centralindia"
    allocation_method = "Static"
  }
  pip2 = {
    name              = "azurebasion_pip"
    rg_name           = "rg_prod"
    location          = "centralindia"
    allocation_method = "Static"
  }

}

vms = {
  vm1 = {
    nic_name       = "nic1_frontend"
    location       = "centralindia"
    rg_name        = "rg_prod"
    vm_name        = "frontendvm"
    size           = "Standard_D4_v5"
    admin_username = "adminuser"
    admin_password = "Admin@123"
    subnet_name    = "frontend_subnet"
    vnet_name      = "prod_vnet"

  }
}

natgw = {
  natgw1 = {
  name                    = "frontendnatgateway"
  location                = "centralindia"
  resource_group_name     = "rg_prod"
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
  }
}