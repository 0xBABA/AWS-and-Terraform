variable "web_instances_count" {
  type    = number
  default = 2
}

variable "ami_id" {
  type    = string
  default = ""
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}
variable "key_name" {
  type    = string
  default = ""
}

variable "subnet_id" {
  type    = string
  default = ""
}

variable "userdata_path" {
  type = string
}

variable "volumes_type" {
  type    = string
  default = "gp2"
}

variable "root_disk_size" {
  type    = number
  default = 10
}

variable "encrypted_disk_size" {
  type    = number
  default = 10
}

variable "nginx_encrypted_disk_device_name" {
  type    = string
  default = "xvdh"
}

variable "instance_prefix" {
  type    = string
  default = "web"
}

variable "vpc_id" {
  type = string
}
