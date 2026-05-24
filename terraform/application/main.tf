<<<<<<< HEAD


resource "azurerm_resource_group" "rg1" {
  name     = var.rg_name
  location = local.location
}

resource "azurerm_user_assigned_identity" "rg1-id" {
  location            = var.region
  name                = "tf-id-demo"
  resource_group_name = var.rg_name #tf handling internal dependencies
}

resource "azurerm_user_assigned_identity" "rg1-id2" {
  location            = var.region
  name                = "tf-id-demo-2"
  resource_group_name = var.rg_name #tf handling internal dependencies
}

data "azurerm_resource_group" "rg2" {
  name = "tf-demo2"
}

output "id" {
  value = data.azurerm_resource_group.rg2
}

resource "azurerm_user_assigned_identity" "rg2-id" {
  location            = var.region
  name                = "tf-id-demo2"
  resource_group_name = data.azurerm_resource_group.rg2.name #data sources example
}

# resource "azurerm_storage_account" "example" {
#   count                             = var.create_stgaccount ? 1 : 0
#   name                              = "storageaccountname"
#   resource_group_name               = var.rg_name
#   location                          = var.region
#   account_tier                      = var.account_tier
#   account_replication_type          = "GRS"
#   infrastructure_encryption_enabled = var.enable_encryption
#   nfsv3_enabled                     = false
#   min_tls_version                   = "TLS1_2"

#   tags = var.tags
# }

# resource "azurerm_virtual_network" "example" {
#   name                = "example-network"
#   location            = var.region
#   resource_group_name = var.rg_name
#   address_space       = ["10.0.0.0/16"]
#   #dns_servers         = ["10.0.0.4", "10.0.0.5"]

#   # subnet {
#   #   name             = "subnet1"
#   #   address_prefixes = ["10.0.1.0/24"]
#   # }

#   # subnet {
#   #   name             = "subnet2"
#   #   address_prefixes = ["10.0.2.0/24"]
#   #   security_group   = azurerm_network_security_group.example.id
#   # }
#   dynamic "subnet" {
#     for_each = var.subnet_cidr
#     content {
#       name = "subnet-${index(var.subnet_cidr, subnet.value) +1}"
#       address_prefixes = [subnet.value]
#     }
#   }

#   tags = var.tags
# }
=======
locals {
  env = terraform.workspace
  env_config = {
    dev  = { vm_size = "Standard_B1s", vm_count = 1, address_space = "10.0.1.0/16" }
    prod = { vm_size = "Standard_B2s", vm_count = 2, address_space = "10.0.2.0/16" }
  }
  config = local.env_config[local.env]
  location = local.env == "dev" ? "canadacentral" : "eastus"
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources-${local.env}"
  location = var.location
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network-${local.env}"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "internal-${local.env}"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = [cidrsubnet(local.config.address_space, 8, 1)]
}

resource "azurerm_network_interface" "example" {
  count               = local.config.vm_count
  name                = "example-nic-${local.env}-${count.index}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal-${count.index}"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  count               = local.config.vm_count
  name                = "example-machine-${local.env}-${count.index}"
  resource_group_name = azurerm_resource_group.example.name
  location            = var.location
  size                = local.config.vm_size
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.example[count.index].id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("/Users/piyushsharma/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
>>>>>>> 239fe38a3884665d707ef00cdf12bfa57a1563ef
