variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "owner_tag" {
  type    = string
  default = "yoad"
}

variable "key_name" {
  description = "The key name of the Key Pair to use for the instances"
  default     = "yoad_opsschool_ec2-rsa"
  type        = string
}

variable "instance_type" {
  description = "The type of the nginx EC2, for example - t2.medium"
  type        = string
  default     = "t2.micro"
}

variable "userdata_path" {
  type    = string
  default = "/home/ubuntu/AWS-and-Terraform/Homework2/userdata.sh"
}

variable "root_disk_size" {
  type    = number
  default = "10"
}

variable "encrypted_disk_size" {
  type    = number
  default = "10"
}

variable "volume_type" {
  type    = string
  default = "gp2"
}

variable "vpc_name" {
  default = "main_vpc"
}

variable "global_name_prefix" {
  default = "hw3"
}

variable "public_subnet_prefix" {
  default = "public_sn"
}
