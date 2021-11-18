variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "owner_tag" {
  type    = string
  default = "yoad"
}

variable "vpc_name" {
  default = "main_vpc"
}

variable "global_name_prefix" {
  default = "hw4"
}

variable "db_instances_count" {
  type    = number
  default = 2
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  description = "The key name of the Key Pair to use for the instances"
  default     = "yoad_opsschool_ec2-rsa"
  type        = string
}

variable "private_subnet_prefix" {
  type    = string
  default = "private_sn"
}

variable "volumes_type" {
  type    = string
  default = "gp2"
}

variable "root_disk_size" {
  type    = number
  default = 10
}

variable "instance_prefix" {
  type    = string
  default = "db"
}
