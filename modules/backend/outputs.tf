output "backend_api_url" {
  value       = "https://${local.backend_webapp_name}.azurewebsites.net"
  description = "The URL of the backend API"
}
