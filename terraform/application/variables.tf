<<<<<<< HEAD
variable "region" {
  description = "The region where the resource will be deployed"
  type        = string
  default     = ""
}

variable "rg_name" {
  description = "value"
  type        = string
  default     = "tf-demo"

}

variable "account_tier" {
  description = "The account tier for storage account"
  type        = string
  default     = "Standard"

}

variable "enable_encryption" {
  description = "Whether or not the stg account has to be encrypted"
  type        = bool
  default     = true

}

variable "create_stgaccount" {
  description = "determines whether to create a stg account"
  type        = bool
  default     = true

}

variable "tags" {
    description = "A map of tags to assign the resources"
    type = map(string)
    default = {
      "environment" = "demo"
    }
  
}

variable "subnet_cidr" {
    description = "defining what the different cidr ranges would be"
    type = list(string)
    default = [ "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
  
=======
variable "environment" {
  description = "The environment to deploy to (dev, prod)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "The Azure region to deploy resources in"
  type        = string
  default     = "canadacentral"
}

variable "address_space" {
  description = "The address space for the virtual network"
  type        = string
  default     = "10.0.0.0/16"
>>>>>>> 239fe38a3884665d707ef00cdf12bfa57a1563ef
}