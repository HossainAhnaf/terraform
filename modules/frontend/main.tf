
resource "azurerm_service_plan" "frontend-plan" {
  name                = local.frontend_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  os_type             = var.os_type
}

resource "azurerm_linux_web_app" "frontend" {
  name                = local.frontend_webapp_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.frontend-plan.id

  site_config {
    always_on = false
    application_stack {
      docker_registry_url = var.docker_registry_url
      docker_image_name   = var.docker_image_name
    }
  }
}
