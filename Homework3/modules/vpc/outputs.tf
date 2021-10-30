output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main_vpc.*.id
}

output "private_subnet_id" {
  description = "The ID of the private subnets"
  value       = [aws_subnet.private_sn.*.id]
}

output "public_subnet_id" {
  description = "The ID of the public subnets"
  value       = [aws_subnet.public_sn.*.id]
}
