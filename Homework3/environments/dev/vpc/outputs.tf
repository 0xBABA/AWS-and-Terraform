output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_id
}
