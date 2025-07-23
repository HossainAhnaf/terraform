locals {
}
locals {
  naming_suffix = ["backend"]
  filtered_suffix = [
    for item in var.extra_naming_suffix : item
    if item != terraform.workspace
  ]
}
