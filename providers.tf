
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.33.0"
    } 
  }
  required_version = " >= 1.10.0"
  
}

provider "azurerm" {
  subscription_id = "fc4b0a21-cf38-4354-9ee7-f3532dd03c57"
  features {}

}