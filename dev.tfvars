location = "centralus"

server_sku_name          = "B_Standard_B1ms"
database_version         = "8.0.21"
administrator_login      = "mysqladmin"
administrator_password   = "P@ssw0rd123!" # ⚠️ NEVER commit this file to Git
db_private_dns_zone_name = "privatelink.mysql.database.azure.com"

frontend_asp_sku_name                        = "B1"
frontend_os_type                             = "Linux"
frontend_asp_zone_balancing_enabled          = false
frontend_asp_premium_plan_auto_scale_enabled = false
frontend_asp_worker_count                    = 1

backend_asp_sku_name                        = "B1"
backend_os_type                             = "Linux"
backend_asp_worker_count                    = 1
backend_asp_zone_balancing_enabled          = false
backend_asp_premium_plan_auto_scale_enabled = false

docker_registry_url        = "https://ghcr.io/hossainahnaf"
backend_docker_image_name  = "spring-react-devops-appservice-backend"
backend_docker_image_tag   = "latest"
frontend_docker_image_name = "spring-react-devops-appservice-frontend"
frontend_docker_image_tag  = "latest"
