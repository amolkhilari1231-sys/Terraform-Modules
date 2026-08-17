output "storage_account" {
  value = {
    for k, v in azurerm_storage_account.storage_account : k => {
      id   = v.id
      name = v.name
    }
  }
  description = "Map of created Storage Accounts"
}
