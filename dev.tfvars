location = "centralus"

server_sku_name        = "B_Standard_B1ms"
database_version       = "8.0.21"
administrator_login    = "mysqladmin"
administrator_password = "P@ssw0rd123!" # ⚠️ NEVER commit this file to Git

frontend_sku_name     = "B1"
frontend_os_type      = "Linux"
frontend_worker_count = 1

backend_sku_name     = "B1"
backend_os_type      = "Linux"
backend_worker_count = 1

docker_registry_url        = "https://ghcr.io/hossainahnaf"
backend_docker_image_name  = "spring-react-devops-appservice-backend"
backend_docker_image_tag   = "latest"
frontend_docker_image_name = "spring-react-devops-appservice-frontend"
frontend_docker_image_tag  = "latest"
