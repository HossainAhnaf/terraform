output "backend_api_url" {
  value       = "https://${module.avm-res-web-site.name}.azurewebsites.net"
  description = "The URL of the backend API"
}
