

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

resource "azurerm_service_plan" "backend-plan" {
  name                = local.backend_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  os_type             = var.os_type
}

resource "azurerm_linux_web_app" "backend" {
  name                = local.backend_webapp_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.backend-plan.id

  site_config {
    always_on = true
    application_stack {
      docker_registry_url = var.docker_registry_url
      docker_image_name   = var.docker_image_name
    }
  }

  app_settings = var.app_settings
}

resource "azurerm_app_service_virtual_network_swift_connection" "backend" {
  app_service_id = azurerm_linux_web_app.backend.id
  subnet_id      = azurerm_subnet.backend_subnet.id
}
