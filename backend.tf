terraform {

  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "tfstatehasan"
    container_name       = "tfstate01"
    key                  = "spring-react-devops.terraform.tfstate"
    subscription_id      = "fc4b0a21-cf38-4354-9ee7-f3532dd03c57"

  }
}
