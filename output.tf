output "postgresql_server" {
  value = azurerm_postgresql_server.postgresql_server.name
}

output "postgresql_db" {
  value = azurerm_postgresql_database.postgresql_db.name
}