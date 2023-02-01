terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "postgresql_rg" {
  name     = "dss-postgresql-rg"
  location = "East US"
}

resource "azurerm_postgresql_server" "postgresql_server" {
  name = "dss-postgresql-server"
  location = azurerm_resource_group.postgresql_rg.location
  resource_group_name = azurerm_resource_group.postgresql_rg.name

  administrator_login          = var.postgresql-admin-login
  administrator_login_password = var.postgresql-admin-password

  sku_name = var.postgresql-sku-name
  version  = var.postgresql-version

  storage_mb        = var.postgresql-storage
  auto_grow_enabled = true

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}

resource "azurerm_postgresql_database" "postgresql_db" {
  name                = "dss-postgresql-db"
  resource_group_name = azurerm_resource_group.postgresql_rg.name
  server_name         = azurerm_postgresql_server.postgresql_server.name
  charset             = "utf8"
  collation           = "English_United States.1252"
}

resource "azurerm_postgresql_firewall_rule" "postgresql_fw_rule" {
  name                = "PostgreSQL-access"
  resource_group_name = azurerm_resource_group.postgresql_rg.name
  server_name         = azurerm_postgresql_server.postgresql_server.name
  start_ip_address    = "210.170.94.100"
  end_ip_address      = "210.170.94.120"
}
