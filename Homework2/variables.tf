variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "owner_tag" {
  description = "The owner tag will be applied to every resource in the project through the 'default variables' feature"
  default     = "yoad"
  type        = string
}

variable "private_subnet_cidrs" {
  description = "CIDR ranges for private subnets"
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "public_subnet_cidrs" {
  description = "CIDR ranges for private subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
