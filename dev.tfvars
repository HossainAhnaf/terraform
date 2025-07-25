location = "centralus"

server_sku_name = "B_Standard_B1ms"
server_storage = {
  size_gb            = 20
  auto_grow_enabled  = false
  io_scaling_enabled = false
}

database_version         = "8.0.21"
administrator_login      = "mysqladmin"
administrator_password   = "P@ssw0rd123!" # ⚠️ NEVER commit this file to Git
db_private_dns_zone_name = "privatelink.mysql.database.azure.com"

asp_os_type                  = "Linux"
asp_sku_name                 = "S1"
asp_zone_balancing_enabled   = false
asp_rule_based_scale_enabled = true
asp_worker_count             = 1

backend_os_type  = "Linux"
frontend_os_type = "Linux"

docker_registry_url        = "https://ghcr.io/hossainahnaf"
backend_docker_image_name  = "spring-react-devops-appservice-backend"
backend_docker_image_tag   = "latest"
frontend_docker_image_name = "spring-react-devops-appservice-frontend"
frontend_docker_image_tag  = "latest"
