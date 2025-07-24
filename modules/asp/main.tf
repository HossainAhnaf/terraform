module "naming" {
  source = "git::https://github.com/Azure/terraform-azurerm-naming.git?ref=75d5afa"
  suffix = var.naming_suffix
}

resource "azurerm_monitor_autoscale_setting" "app_service_plan_autoscale" {
  count               = var.premium_plan_auto_scale_enabled ? 1 : 0
  name                = module.naming.monitor_autoscale_setting.name
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = module.avm-res-web-serverfarm.resource_id
  enabled             = true
  profile {
    name = var.autoscale_profile_name
    capacity {
      default = var.capacity.default
      minimum = var.capacity.minimum
      maximum = var.capacity.maximum
    }
    # scale up
    rule {
      metric_trigger {
        metric_name        = var.scale_up_rule.metric_trigger.metric_name
        metric_resource_id = module.avm-res-web-serverfarm.resource_id
        operator           = "GreaterThan"
        threshold          = var.scale_up_rule.metric_trigger.threshold
        statistic          = "Average"
        time_aggregation   = "Average"
        time_grain         = var.scale_up_rule.metric_trigger.time_grain
        time_window        = var.scale_up_rule.metric_trigger.time_window
      }
      scale_action {
        direction = "Increase"
        type      = var.scale_up_rule.scale_action.type
        value     = var.scale_up_rule.scale_action.value
        cooldown  = var.scale_up_rule.scale_action.cooldown
      }
    }
    # scale down
    rule {
      metric_trigger {
        metric_name        = var.scale_down_rule.metric_trigger.metric_name
        metric_resource_id = module.avm-res-web-serverfarm.resource_id
        operator           = "LessThan"
        threshold          = var.scale_down_rule.metric_trigger.threshold
        statistic          = "Average"
        time_aggregation   = "Average"
        time_grain         = var.scale_down_rule.metric_trigger.time_grain
        time_window        = var.scale_down_rule.metric_trigger.time_window
      }
      scale_action {
        direction = "Decrease"
        type      = var.scale_down_rule.scale_action.type
        value     = var.scale_down_rule.scale_action.value
        cooldown  = var.scale_down_rule.scale_action.cooldown
      }
    }

  }
}


module "avm-res-web-serverfarm" {
  source                          = "git::https://github.com/Azure/terraform-azurerm-avm-res-web-serverfarm.git?ref=8ca49e283a7ede30927377cee1154b3cde8a81cc"
  enable_telemetry                = false
  name                            = module.naming.app_service_plan.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  os_type                         = var.os_type
  sku_name                        = var.sku_name
  worker_count                    = var.worker_count
  zone_balancing_enabled          = var.zone_balancing_enabled
  premium_plan_auto_scale_enabled = var.premium_plan_auto_scale_enabled
}
