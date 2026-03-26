data "terraform_remote_state" "landing_zone" {
  backend = "azurerm"

  config = {
    resource_group_name  = var.lz_state_rg
    storage_account_name = var.lz_state_sa
    container_name       = var.lz_state_container
    key                  = var.lz_state_key
  }
}

locals {
  aks_subnet_id       = data.terraform_remote_state.landing_zone.outputs.aks_subnet_id
  firewall_private_ip = data.terraform_remote_state.landing_zone.outputs.firewall_private_ip
}

# No route table association here.
# The Landing Zone owns all UDR wiring.