provider "azurerm" {
  version = "~>2.0"
  features {}
}

terraform {
  backend "azurerm" {
    storage_account_name = "terraformkj"
    container_name       = "terraform"
    key                  = "terraform.tfstate"
    access_key           = "XXX"
  }
}