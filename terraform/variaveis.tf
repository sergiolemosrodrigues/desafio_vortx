variable "regiao" {
  description = "Regiao onde serao criados os objetos."
  default     = "eastus"
}

variable "rg" {
  description = "Nome do Resource Group."
  default     = "SergioRodrigues_RG"
}

variable "vn_rede_nome" {
  description = "Nome da Rede Virtual."
  default     = "SergioRodrigues_VN"
}

variable "vn_rede_enderecos" {
  description = "Enderecos da Rede Virtual."
  default     = "10.0.0.0/16"
}

variable "sn_subrede_nome" {
  description = "Enderecos da subnet."
  default     = "SergioRodrigues_SN"
}

variable "sn_subrede_enderecos" {
  description = "Enderecos da subnet."
  default     = "10.0.10.0/24"
}

variable "rede_origem" {
  description = "Rede de origem."
  default     = "*"
}

variable "sg" {
  description = "Grupo de seguranca."
  default     = "SergioRodrigues_SG"
}

variable "pr" {
  description = "Placa de Rede."
  default     = "SergioRodrigues_PR"
}

variable "ippublico" {
  description = "IP Publico."
  default     = "SergioRodrigues_IPPUBLICO"
}

variable "configuracaoip" {
  description = "IP Interno."
  default     = "SergioRodrigues_IPINTERNO"
}

variable "servidor" {
  description = "Nome do host."
  default     = "sergio-1-rodrigues"
}

variable "tamanho" {
  description = "Tamanho da VM."
  default     = "Standard_A1_v2"
}

variable "imagem" {
  description = "Nome da imagem."
  default     = "Canonical"
}

variable "imagem_offer" {
  description = "Nome do offer"
  default     = "UbuntuServer"
}

variable "imagem_sku" {
  description = "SKU da imagem"
  default     = "18.04-LTS"
}

variable "imagem_version" {
  description = "Versao da imagem"
  default     = "latest"
}

variable "admin_username" {
  description = "Administrador"
  default     = "useradmin"
}

variable "admin_password" {
  description = "Senha do Admin"
  default     = "Admin123!"
}
