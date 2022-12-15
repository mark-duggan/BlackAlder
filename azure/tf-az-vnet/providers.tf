terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.35"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

##################################################################################
# PROVIDERS
##################################################################################

provider "azurerm" {
  skip_provider_registration = "true"
  features {}
}
