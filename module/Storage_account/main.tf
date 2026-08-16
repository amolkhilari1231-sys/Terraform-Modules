variable "storage_account" {}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account.name
  resource_group_name      = var.storage_account.resource_group_name
  location                 = var.storage_account.location
  account_tier             = var.storage_account.account_tier
  account_replication_type = var.storage_account.account_replication_type
}