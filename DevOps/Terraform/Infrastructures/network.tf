resource "azurerm_network_security_group" "az_func_network_sg" {
  name                = "example-security-group"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Virtual Network
resource "azurerm_virtual_network" "az_func_network" {
  name                = "az-func-vn-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Subnet 1: internal
resource "azurerm_subnet" "az_func_subnet_int" {
  name                 = "subnet-int-az-func"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.az_func_network.name
  address_prefixes     = ["10.0.2.0/24"]

  delegation {
    name = "example-delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

# Subnet 2: private Endpoint
resource "azurerm_subnet" "az_func_subnet_pe" {
  name                 = "subnet-pe-az-func"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.az_func_network.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create Network Interface
resource "azurerm_network_interface" "az_func_nic" {
  name                = "pe-nic-exampleazfunc"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.az_func_subnet_pe.id
    private_ip_address_allocation = "Dynamic"
  }
}
