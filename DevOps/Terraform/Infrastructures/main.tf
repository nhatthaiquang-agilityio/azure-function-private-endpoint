terraform {
  required_providers {

    azurerm = {
      version = ">= 3.0, < 4.0"
      source = "hashicorp/azurerm"
    }

  }

  backend "azurerm" {

  }
}

provider "azurerm" {
  features {}
}
