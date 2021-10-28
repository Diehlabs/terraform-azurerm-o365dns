locals {
  tags = {
    location = "westus"
    resname  = "tfmodule-o365dns-test"
  }
}

data "terraform_remote_state" "tfcloud" {
  backend = "remote"
  config = {
    organization = "Diehlabs"
    workspaces = {
      name = "tfcloud-mgmt"
    }
  }
}

provider "azurerm" {
  features {}
  client_id       = data.terraform_remote_state.tfcloud.outputs.arm_spn_prod.ARM_CLIENT_ID
  client_secret   = data.terraform_remote_state.tfcloud.outputs.arm_spn_prod.ARM_CLIENT_SECRET
  subscription_id = data.terraform_remote_state.tfcloud.outputs.arm_spn_prod.ARM_SUBSCRIPTION_ID
  tenant_id       = data.terraform_remote_state.tfcloud.outputs.arm_spn_prod.ARM_TENANT_ID
}

resource "azurerm_resource_group" "rg" {
  name     = "rd-${local.tags.resname}"
  location = local.tags.location
  tags     = local.tags
}

resource "azurerm_dns_zone" "diehlabs_com" {
  resource_group_name = azurerm_resource_group.rg.name
  name                = "terratest.diehlabs.com"
  tags                = local.tags
}

module "o365_dns_diehlabs" {
  depends_on = [azurerm_dns_zone.diehlabs_com]
  source     = "../.."
  zone_name  = azurerm_dns_zone.diehlabs_com.name
  rg_name    = azurerm_resource_group.rg.name
  tags       = local.tags
}
