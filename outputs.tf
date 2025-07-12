output "database_name" {
  value       = module.database.database_name
  description = "The name of the database"
}

output "project_name" {
  value = local.project_name
}
