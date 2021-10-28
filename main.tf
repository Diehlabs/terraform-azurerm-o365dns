######################
# Microsoft Exchange #
######################

resource "azurerm_dns_txt_record" "o365_diehlabs" {
  name                = "@"
  zone_name           = var.zone_name
  resource_group_name = var.rg_name
  ttl                 = 3600

  record {
    value = "v=spf1 include:spf.protection.outlook.com -all"
  }

  tags = var.tags
}

resource "azurerm_dns_mx_record" "o365_diehlabs" {
  name                = "@"
  zone_name           = var.zone_name
  resource_group_name = var.rg_name
  ttl                 = 3600

  record {
    preference = 0
    exchange   = local.mx_record
  }

  tags = var.tags
}

resource "azurerm_dns_cname_record" "o365_diehlabs_exchange" {
  name                = "autodiscover"
  zone_name           = var.zone_name
  resource_group_name = var.rg_name
  ttl                 = 3600
  record              = "autodiscover.outlook.com"
  tags                = var.tags
}

######################
# Skype for business #
######################

resource "azurerm_dns_cname_record" "sip" {
  name                = "sip"
  zone_name           = var.zone_name
  resource_group_name = var.rg_name
  ttl                 = 3600
  record              = "sipdir.online.lync.com"
  tags                = var.tags
}

resource "azurerm_dns_cname_record" "lyncdiscover" {
  name                = "lyncdiscover"
  zone_name           = var.zone_name
  resource_group_name = var.rg_name
  ttl                 = 3600
  record              = "webdir.online.lync.com"
  tags                = var.tags
}

resource "azurerm_dns_srv_record" "sip_tls" {
  name                = "_sip._tls"
  zone_name           = var.zone_name
  resource_group_name = var.rg_name
  ttl                 = 3600

  record {
    priority = 100
    weight   = 1
    port     = 443
    target   = "sipdir.online.lync.com"
  }

  tags = var.tags

}

resource "azurerm_dns_srv_record" "sip_federation_tls" {
  name                = "_sipfederationtls._tcp"
  zone_name           = var.zone_name
  resource_group_name = var.rg_name
  ttl                 = 3600

  record {
    priority = 100
    weight   = 1
    port     = 5061
    target   = "sipfed.online.lync.com"
  }

  tags = var.tags

}

#############################
# Basic Mobility & Security #
#############################

resource "azurerm_dns_cname_record" "enterpriseregistration" {
  name                = "enterpriseregistration"
  zone_name           = var.zone_name
  resource_group_name = var.rg_name
  ttl                 = 3600
  record              = "enterpriseregistration.windows.net"
  tags                = var.tags
}

resource "azurerm_dns_cname_record" "enterpriseenrollment" {
  name                = "enterpriseenrollment"
  zone_name           = var.zone_name
  resource_group_name = var.rg_name
  ttl                 = 3600
  record              = "enterpriseenrollment.manage.microsoft.com"
  tags                = var.tags
}
