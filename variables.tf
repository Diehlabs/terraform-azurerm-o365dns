variable "zone_name" {
  description = "DNS zone name"
  type        = string
}

variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to objects"
  type        = map(any)
}
