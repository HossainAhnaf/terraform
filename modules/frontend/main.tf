module "avm-res-web-serverfarm" {
  source                 = "git::https://github.com/Azure/terraform-azurerm-avm-res-web-serverfarm.git?ref=8ca49e283a7ede30927377cee1154b3cde8a81cc"
  enable_telemetry       = false
  name                   = var.frontend_plan_name
  location               = var.location
  resource_group_name    = var.resource_group_name
  os_type                = var.os_type
  sku_name               = var.sku_name
  worker_count           = var.worker_count
  zone_balancing_enabled = false #var.zone_balancing_enabled
  # premium_plan_auto_scale_enabled = var.premium_plan_auto_scale_enabled
}


module "avm-res-web-site" {
  source                   = "git::https://github.com/Azure/terraform-azurerm-avm-res-web-site.git?ref=c9382221b09b017c15c91c0c19ac7b5a43ceec19"
  enable_telemetry         = false
  name                     = var.frontend_webapp_name
  kind                     = "webapp"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  service_plan_resource_id = module.avm-res-web-serverfarm.resource_id
  os_type                  = var.os_type

  site_config = {
    application_stack = {
      docker = {
        docker_registry_url = var.docker_registry_url
        docker_image_name   = "${var.docker_image_name}:${var.docker_image_tag}"
      }
    }
  }
}
