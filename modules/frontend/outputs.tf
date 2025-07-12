output "frontend_url" {
  value       = "https://${local.frontend_webapp_name}.azurewebsites.net"
  description = "The URL of the frontend"

}
