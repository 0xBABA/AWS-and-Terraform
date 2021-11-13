
variable "global_name_prefix" {
  type    = string
  default = ""
}

variable "azs" {
  type    = list(string)
  default = []
}
variable "vpc_cidr_block" {
  type = string
}

variable "vpc_name" {
  type    = string
  default = "main_vpc"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = []
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = []
}

variable "public_subnet_prefix" {
  type    = string
  default = "public_sn"
}

variable "private_subnet_prefix" {
  type    = string
  default = "private_sn"
}

variable "public_route_table_name" {
  type    = string
  default = "public_rt"
}

variable "private_route_table_name" {
  type    = string
  default = "private_rt"
}










