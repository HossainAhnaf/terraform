terraform {

  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "tfstatehasan"
    container_name       = "tfstate01"
    key                  = "${local.project_name}.terraform.tfstate"
  }
}
