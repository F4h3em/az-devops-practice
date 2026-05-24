terraform {
  required_version = ">= 1.14.7"
<<<<<<< HEAD
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.68.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "tf-demo2"
    storage_account_name = "tfstatefilestrg"
    container_name = "tfstatestorage"
    key = "tfstate_demo" #filename of the file that will be created
    
  }
}

=======

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.68.0"
    }
  }
}
>>>>>>> 239fe38a3884665d707ef00cdf12bfa57a1563ef
