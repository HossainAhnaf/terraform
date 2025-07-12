locals {
  project_name                  = "spring-react-devops"
  rg_name                       = "${var.prefix}-rg"
  vnet_name                     = "${var.prefix}-vnet"
  db_name                       = "${var.prefix}-mysql-db"
  db_subnet_address_prefix      = ["10.0.1.0/24"]
  backend_subnet_address_prefix = ["10.0.2.0/24"]
  address_space                 = ["10.0.0.0/16"]
}
