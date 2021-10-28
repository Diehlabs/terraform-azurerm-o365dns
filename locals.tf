locals {
  mx_record = "${replace(var.zone_name, ".", "-")}.mail.protection.outlook.com"
}
