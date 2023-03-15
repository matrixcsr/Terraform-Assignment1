resource "azurerm_postgresql_server" "postgresql" {
  name                         = var.server_name
  location                     = var.location
  resource_group_name          = var.rg_name
  sku_name                     = "B_Gen5_1"
  storage_mb                   = 5120
  version                      = "11"
  administrator_login          = "matrix8359"
  administrator_login_password = "Sherway958"
  ssl_enforcement_enabled      = true
}

resource "azurerm_postgresql_database" "postgresql_database" {
  name                = var.db_name
  server_name         = azurerm_postgresql_server.postgresql.name
  resource_group_name = var.rg_name
  charset             = "UTF8"
  collation           = "en_US.utf8"
}
