resource "azurerm_resource_group" "ba-prod-rg" {
  name     = "ba-prod-resources"
  location = "West Europe"
}

resource "azurerm_network_security_group" "ba-prod-sg" {
  name                = "ba-prod-security-group"
  location            = azurerm_resource_group.ba-prod-rg.location
  resource_group_name = azurerm_resource_group.ba-prod-rg.name
}

resource "azurerm_virtual_network" "ba-prod-vnet" {
  name                = "ba-prod-vnet"
  location            = azurerm_resource_group.ba-prod-rg.location
  resource_group_name = azurerm_resource_group.ba-prod-rg.name
  address_space       = ["10.11.0.0/16"]
  dns_servers         = ["10.11.0.4", "10.11.0.5"]

  subnet {
    name           = "ba-prod-subnet1"
    address_prefix = "10.11.1.0/24"
  }

  subnet {
    name           = "ba-prod-subnet2"
    address_prefix = "10.11.2.0/24"
    security_group = azurerm_network_security_group.ba-prod-sg.id
  }

  tags = {
    environment = "Black Alder Production"
  }
}