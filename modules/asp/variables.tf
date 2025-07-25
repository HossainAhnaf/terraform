variable "naming_suffix" {
  description = "The naming suffix"
  type        = list(string)
}

variable "location" {
  description = "The location/region where the resources are created."
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}
variable "autoscale_profile_name" {
  description = "The autoscale profile name"
  type        = string
  default     = "default-autoscale-profile"
}
variable "capacity" {
  description = "Scaling capacity configuration."
  type = object({
    default = number
    minimum = number
    maximum = number
  })
  default = {
    default = 1
    minimum = 1
    maximum = 2
  }
}

variable "scale_out_rule" {
  description = "Scale-out rule configuration."
  type = object({
    metric_trigger = object({
      metric_name = string
      threshold   = number
      time_grain  = string
      time_window = string
    })
    scale_action = object({
      type     = string
      value    = number
      cooldown = string
    })
  })
  default = {
    metric_trigger = {
      metric_name = "CpuPercentage"
      threshold   = 70
      time_grain  = "PT1M"
      time_window = "PT5M"
    }
    scale_action = {
      type     = "ChangeCount"
      value    = 1
      cooldown = "PT1M"
    }
  }
}

variable "scale_in_rule" {
  description = "Scale-in rule configuration."
  type = object({
    metric_trigger = object({
      metric_name = string
      threshold   = number
      time_grain  = string
      time_window = string
    })
    scale_action = object({
      type     = string
      value    = number
      cooldown = string
    })
  })
  default = {
    metric_trigger = {
      metric_name = "CpuPercentage"
      threshold   = 30
      time_grain  = "PT1M"
      time_window = "PT5M"
    }
    scale_action = {
      type     = "ChangeCount"
      value    = 1
      cooldown = "PT1M"
    }
  }
}


variable "zone_balancing_enabled" {
  description = "The zone balancing enabled"
  type        = bool
}

variable "rule_based_scale_enabled" {
  description = "The rule based scale enabled"
  type        = bool
}

variable "sku_name" {
  description = "The sku name"
  type        = string
}

variable "os_type" {
  description = "The os type"
  type        = string
}

variable "worker_count" {
  description = "The worker count"
  type        = number
}
