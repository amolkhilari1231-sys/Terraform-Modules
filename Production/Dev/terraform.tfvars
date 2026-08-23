rgs = {
  rg_hub = {
    name     = "rg-hub-Dev"
    location = "centralindia"
  }
  rg_spoke = {
    name     = "rg-spoke-Dev"
    location = "centralindia"
  }
}

vnets = {
  hub_vnet = {
    name                = "hub-vnet"
    location            = "centralindia"
    resource_group_name = "rg-hub-Dev"
    address_space       = ["10.0.0.0/16"]
  }
  spoke_vnet = {
    name                = "spoke-vnet"
    location            = "centralindia"
    resource_group_name = "rg-spoke-Dev"
    address_space       = ["10.1.0.0/16"]
  }
}

subnets = {
  appgw_subnet = {
    name             = "AppGatewaySubnet"
    vnet_name        = "hub-vnet"
    rg_name          = "rg-hub-Dev"
    address_prefixes = ["10.0.1.0/24"]
  }
  bastion_subnet = {
    name             = "AzureBastionSubnet"
    vnet_name        = "hub-vnet"
    rg_name          = "rg-hub-Dev"
    address_prefixes = ["10.0.2.0/24"]
  }
  frontend_subnet = {
    name             = "frontend-subnet"
    vnet_name        = "spoke-vnet"
    rg_name          = "rg-spoke-Dev"
    address_prefixes = ["10.1.1.0/24"]
  }
  backend_subnet = {
    name             = "backend-subnet"
    vnet_name        = "spoke-vnet"
    rg_name          = "rg-spoke-Dev"
    address_prefixes = ["10.1.2.0/24"]
  }
}

peerings = {
  hub_to_spoke = {
    name            = "hub-to-spoke-peering"
    src_vnet_name   = "hub-vnet"
    src_rg_name     = "rg-hub-Dev"
    remote_vnet_key = "spoke_vnet"
    remote_rg_name  = "rg-spoke-Dev"
  }
  spoke_to_hub = {
    name            = "spoke-to-hub-peering"
    src_vnet_name   = "spoke-vnet"
    src_rg_name     = "rg-spoke-Dev"
    remote_vnet_key = "hub_vnet"
    remote_rg_name  = "rg-hub-Dev"
  }
}

pips = {
  appgw_pip = {
    name              = "pip-appgw"
    rg_name           = "rg-hub-Dev"
    location          = "centralindia"
    allocation_method = "Static"
    sku               = "Standard"
  }
  bastion_pip = {
    name              = "pip-bastion"
    rg_name           = "rg-hub-Dev"
    location          = "centralindia"
    allocation_method = "Static"
    sku               = "Standard"
  }
  natgw_pip = {
    name              = "pip-natgw"
    rg_name           = "rg-spoke-Dev"
    location          = "centralindia"
    allocation_method = "Static"
    sku               = "Standard"
  }
}

app_gateways = {
  appgw1 = {
    name                 = "appgw-hub"
    location             = "centralindia"
    rg_name              = "rg-hub-Dev"
    vnet_name            = "hub-vnet"
    subnet_key           = "appgw_subnet"
    pip_key              = "appgw_pip"
    backend_ip_addresses = ["10.1.1.4"]
    backend_port         = 80
  }
}

bastions = {
  bastion1 = {
    name       = "bastion-hub"
    location   = "centralindia"
    rg_name    = "rg-hub-Dev"
    vnet_name  = "hub-vnet"
    subnet_key = "bastion_subnet"
    pip_key    = "bastion_pip"
    sku        = "Standard"
  }
}

natgw = {
  natgw1 = {
    name                = "spoke-natgateway"
    location            = "centralindia"
    resource_group_name = "rg-spoke-Dev"
    pip_key             = "natgw_pip"
    subnet_key          = "frontend_subnet"
    vnet_name           = "spoke-vnet"
    sku_name            = "Standard"
  }
}

nsgs = {
  nsg_appgw = {
    name       = "nsg-appgw"
    location   = "centralindia"
    rg_name    = "rg-hub-Dev"
    vnet_name  = "hub-vnet"
    subnet_key = "appgw_subnet"
    rules = [
      {
        name                       = "allow-http-inbound"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        destination_port_range     = "80"
        source_address_prefix      = "Internet"
        destination_address_prefix = "*"
      },
      {
        name                       = "allow-https-inbound"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        destination_port_range     = "443"
        source_address_prefix      = "Internet"
        destination_address_prefix = "*"
      },
      {
        name                       = "allow-gateway-manager"
        priority                   = 120
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        destination_port_range     = "65200-65535"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
      }
    ]
  }

  nsg_spoke_frontend = {
    name       = "nsg-spoke-frontend"
    location   = "centralindia"
    rg_name    = "rg-spoke-Dev"
    vnet_name  = "spoke-vnet"
    subnet_key = "frontend_subnet"
    rules = [
      {
        name                       = "allow-appgw-inbound"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        destination_port_range     = "80"
        source_address_prefix      = "10.0.1.0/24"
        destination_address_prefix = "*"
      },
      {
        name                       = "allow-bastion-ssh"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        destination_port_range     = "22"
        source_address_prefix      = "10.0.2.0/24"
        destination_address_prefix = "*"
      },
      {
        name                       = "deny-direct-internet"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Deny"
        protocol                   = "*"
        destination_port_range     = "*"
        source_address_prefix      = "Internet"
        destination_address_prefix = "*"
      }
    ]
  }
}

vms = {
  vm1 = {
    nic_name = "nic-spoke-web"
    location = "centralindia"
    rg_name  = "rg-spoke-Dev"
    vm_name  = "spoke-web-vm"
    size     = "Standard_B2als_v2"

    admin_username = "azureuser"
    admin_password = "Password1234!"

    subnet_key = "frontend_subnet"
    vnet_name  = "spoke-vnet"


  }
}

storage_account = {
  storage_account1 = {
    name                     = "spokedstore12345"
    resource_group_name      = "rg-spoke-Dev"
    location                 = "centralindia"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}
