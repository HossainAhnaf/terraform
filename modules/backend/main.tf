

resource "azurerm_subnet" "backend_subnet" {
  name                 = local.backend_subnet_name
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

module "avm-res-web-serverfarm" {
  source              = "git::https://github.com/Azure/terraform-azurerm-avm-res-web-serverfarm.git?ref=8ca49e283a7ede30927377cee1154b3cde8a81cc"
  enable_telemetry    = false
  name                = local.backend_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = var.os_type
  sku_name            = var.sku_name
}


module "avm-res-web-site" {
  source                   = "git::https://github.com/Azure/terraform-azurerm-avm-res-web-site.git?ref=c9382221b09b017c15c91c0c19ac7b5a43ceec19"
  enable_telemetry         = false
  name                     = local.backend_webapp_name
  kind                     = "webapp"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  service_plan_resource_id = module.avm-res-web-serverfarm.resource_id
  os_type                  = var.os_type
  site_config = {
    application_stack = {
      docker = {
        registry_url = var.docker_registry_url
        image_name   = var.docker_image_name
        image_tag    = var.docker_image_tag
      }
    }
  }
  app_settings = var.app_settings
}


resource "azurerm_app_service_virtual_network_swift_connection" "backend" {
  app_service_id = module.avm-res-web-site.resource_id
  subnet_id      = azurerm_subnet.backend_subnet.id
}
