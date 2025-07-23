
output "backend_api_url" {
  value       = module.backend.backend_api_url
  description = "The URL of the backend API"
}
output "frontend_url" {
  value       = module.frontend.frontend_url
  description = "The URL of the frontend"
}
