resource "azurerm_network_security_group" "az_func_network_sg" {
  name                = "example-security-group"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Virtual Network
resource "azurerm_virtual_network" "az_func_network" {
  name                = "${random_pet.prefix.id}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Subnet 1
resource "azurerm_subnet" "az_func_subnet" {
  name                 = "subnet-1"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.az_func_network.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create Network Interface
resource "azurerm_network_interface" "example" {
  name                = "pe-nic-exampleazfunc"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.az_func_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
