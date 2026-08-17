variable "rgs" {
  type = any
}

variable "vnets" {
  type = any
}

variable "subnets" {
  type = any
}

variable "pips" {
  type = any
}

variable "vms" {
  type = any
}

variable "natgw" {
  type = any
}

variable "storage_account" {
  type = any
}

variable "app_gateways" {
  type    = any
  default = {}
}

variable "bastions" {
  type    = any
  default = {}
}

variable "nsgs" {
  type    = any
  default = {}
}

variable "peerings" {
  type    = any
  default = {}
}