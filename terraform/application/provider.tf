<<<<<<< HEAD
provider "azurerm" {
  features {}
  # client_id = ""
  # client_secret= ""
  # alias = "dev"
  tenant_id       = "5212c671-c489-45c8-b8d6-d86b858d3bc2"
  subscription_id = "d9926180-7473-4761-886a-f5124e9b02cd"
  use_cli         = true #only for local testing
}



=======
locals {
  subscriptions = {
    dev  = "99852d3c-e87c-4017-9a07-9c99dd605e1b"
    prod = "99852d3c-e87c-4017-9a07-9c99dd605e1b"
  }
}

provider "azurerm" {
  features {}
  # client_id       = ""
  # client_secret   = ""
  tenant_id       = "6ba9d606-3474-492c-9a99-c2c94ad5462f"
  subscription_id = local.subscriptions[terraform.workspace]
  use_cli         = true
}
>>>>>>> 239fe38a3884665d707ef00cdf12bfa57a1563ef
