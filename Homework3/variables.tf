variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "owner_tag" {
  description = "The owner tag will be applied to every resource in the project through the 'default variables' feature"
  default     = "yoad"
  type        = string
}

variable "key_name" {
  default     = "yoad_opsschool_ec2-rsa"
  description = "The key name of the Key Pair to use for the instances"
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
  description = "The size of the root disk"
  default     = "10"
}

variable "private_subnet_cidrs" {
  description = "CIDR ranges for private subnets"
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "public_subnet_cidrs" {
  description = "CIDR ranges for private subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
