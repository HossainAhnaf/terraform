module "naming" {
  source = "git::https://github.com/Azure/terraform-azurerm-naming.git?ref=75d5afa"
  suffix = concat(local.naming_suffix, local.filtered_suffix)
}

module "asp" {
  source                   = "../asp"
  naming_suffix            = concat(local.naming_suffix, local.filtered_suffix)
  resource_group_name      = var.resource_group_name
  location                 = var.location
  os_type                  = var.os_type
  sku_name                 = var.asp_sku_name
  worker_count             = var.asp_worker_count
  zone_balancing_enabled   = var.asp_zone_balancing_enabled
  rule_based_scale_enabled = var.asp_rule_based_scale_enabled
}


resource "azurerm_subnet" "backend_subnet" {
  name                 = module.naming.subnet.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes

  delegation {
    name = "appServiceDelegation"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action"
      ]
    }
  }
}

module "avm-res-web-site" {
  source                   = "git::https://github.com/Azure/terraform-azurerm-avm-res-web-site.git?ref=c9382221b09b017c15c91c0c19ac7b5a43ceec19"
  enable_telemetry         = false
  name                     = module.naming.app_service.name
  kind                     = "webapp"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  service_plan_resource_id = module.asp.resource_id
  os_type                  = var.os_type
  site_config = {
    application_stack = {
      docker = {
        docker_registry_url = var.docker_registry_url
        docker_image_name   = "${var.docker_image_name}:${var.docker_image_tag}"
      }
    }
  }
  app_settings = var.app_settings
}


resource "azurerm_app_service_virtual_network_swift_connection" "backend" {
  app_service_id = module.avm-res-web-site.resource_id
  subnet_id      = azurerm_subnet.backend_subnet.id
}
