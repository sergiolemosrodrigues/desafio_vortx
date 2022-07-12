output "ip" {
  value = azurerm_public_ip.SergioRodrigues_Ip.ip_address
}

output "hostname" {
  value = azurerm_public_ip.SergioRodrigues_Ip.fqdn
}
