variable "databricks_account_username" {
  default = "samXXX2@gmail.com"
}

variable "databricks_account_password" {
  default = "DaXXXXXX@3"
}

variable "databricks_account_id" {
  default = "d72fad77-aXXXXXXX-d13"
}

variable "tags" {
  default = {}
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "region" {
  default = "ap-south-1"
}

resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 6
}

locals {
  prefix = "demo${random_string.naming.result}"
}
