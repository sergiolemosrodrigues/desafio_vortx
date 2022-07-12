resource "azurerm_resource_group" "SergioRodrigues_Rg" {
    name     = var.rg
    location = var.regiao
}

resource "azurerm_virtual_network" "SergioRodrigues_Vn" {
  name                = var.vn_rede_nome
  location            = azurerm_resource_group.SergioRodrigues_Rg.location
  address_space       = [var.vn_rede_enderecos]
  resource_group_name = azurerm_resource_group.SergioRodrigues_Rg.name
}

resource "azurerm_subnet" "SergioRodrigues_Sn" {
  name                 = var.sn_subrede_nome
  virtual_network_name = azurerm_virtual_network.SergioRodrigues_Vn.name
  resource_group_name  = azurerm_resource_group.SergioRodrigues_Rg.name
  address_prefixes     = [var.sn_subrede_enderecos]
}

resource "azurerm_network_security_group" "SergioRodrigues_Sg" {
  name                = var.sg
  location            = var.regiao
  resource_group_name = azurerm_resource_group.SergioRodrigues_Rg.name

  security_rule {
    name                       = "HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3000"
    source_address_prefix      = var.rede_origem
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SSH"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.rede_origem
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "JENKINS"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = var.rede_origem
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "SergioRodrigues_Nc" {
  name                      = var.pr
  location                  = var.regiao
  resource_group_name       = azurerm_resource_group.SergioRodrigues_Rg.name

  ip_configuration {
    name                          = var.configuracaoip
    subnet_id                     = azurerm_subnet.SergioRodrigues_Sn.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.SergioRodrigues_Ip.id
  }
}

resource "azurerm_public_ip" "SergioRodrigues_Ip" {
  name                         = var.ippublico
  location                     = var.regiao
  resource_group_name          = azurerm_resource_group.SergioRodrigues_Rg.name
  allocation_method            = "Dynamic"
  domain_name_label            = "sergiorodrigues"
}

resource "azurerm_virtual_machine" "SergioRodrigues_Sr" {
  name                = var.servidor
  location            = var.regiao
  resource_group_name = azurerm_resource_group.SergioRodrigues_Rg.name
  vm_size             = var.tamanho

  network_interface_ids         = [azurerm_network_interface.SergioRodrigues_Nc.id]
  delete_os_disk_on_termination = "true"

  storage_image_reference {
    publisher = var.imagem
    offer     = var.imagem_offer
    sku       = var.imagem_sku
    version   = var.imagem_version
  }

  storage_os_disk {
    name              = "servidor-disco1"
    managed_disk_type = "Standard_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

  os_profile {
    computer_name  = var.servidor
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

#  provisioner "file" {
#    connection {
#       type     = "ssh"
#       host     = azurerm_public_ip.SergioRodrigues_Ip.fqdn
#       user     = var.admin_username
#       password = var.admin_password
#       agent    = false
#       timeout  = "3m"
#    }
#
#    source      = "setup_java.sh"
#    destination = "/home/${var.admin_username}/setup_java.sh"
#  }
#
#  provisioner "file" {
#    connection {
#       type     = "ssh"
#       host     = azurerm_public_ip.SergioRodrigues_Ip.fqdn
#       user     = var.admin_username
#       password = var.admin_password
#       agent    = false
#       timeout  = "3m"
#    }
#
#    source      = "lista_de_plugins"
#    destination = "/home/${var.admin_username}/lista_de_plugins"
#  }
#
#  provisioner "file" {
#    connection {
#       type     = "ssh"
#       host     = azurerm_public_ip.SergioRodrigues_Ip.fqdn
#       user     = var.admin_username
#       password = var.admin_password
#       agent    = false
#       timeout  = "3m"
#    }
#
#    source      = "job.tar.gz"
#    destination = "/home/${var.admin_username}/job.tar.gz"
#  }
#
#  provisioner "file" {
#    connection {
#       type     = "ssh"
#       host     = azurerm_public_ip.SergioRodrigues_Ip.fqdn
#       user     = var.admin_username
#       password = var.admin_password
#       agent    = false
#       timeout  = "3m"
#    }
#
#    source      = "jenkins.model.JenkinsLocationConfiguration.xml"
#    destination = "/home/${var.admin_username}/jenkins.model.JenkinsLocationConfiguration.xml"
#  }
#
#  provisioner "file" {
#    connection {
#       type     = "ssh"
#       host     = azurerm_public_ip.SergioRodrigues_Ip.fqdn
#       user     = var.admin_username
#       password = var.admin_password
#       agent    = false
#       timeout  = "3m"
#    }
#
#    source      = "deploy.sh"
#    destination = "/home/${var.admin_username}/deploy.sh"
#  }
#
#  provisioner "remote-exec" {
#    connection {
#      type     = "ssh"
#      host     = azurerm_public_ip.SergioRodrigues_Ip.fqdn
#      user     = var.admin_username
#      password = var.admin_password
#      agent    = false
#      script_path = "/home/${var.admin_username}/setup_java.sh"
#    }
#
#    inline = [
#      "set -x",
#      "sleep 5",
#      "sudo chmod 755 /home/${var.admin_username}/setup_java.sh",
#      "sleep 5",
#      "sudo /home/${var.admin_username}/setup_java.sh",
#      "sleep 5",
#    ]
# }

}
