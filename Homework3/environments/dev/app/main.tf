

module "web_instance" {
  source   = "../../../modules/app"
  count    = 2
  ami_id   = data.aws_ami.ubuntu-18.id
  key_name = "yoad_opsschool_ec2-rsa"
  # subnet_id           = data.aws_subnet.get_subnet_info
  # subnet_id           = data.aws_subnet.get_subnet_info.*.id
  # subnet_id           = data.tf_vpc_state.public_subnets.outputs.public_subnet_id
  subnet_id             = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0][count.index]
  userdata_path         = var.userdata_path
  volumes_type          = var.volume_type
  root_disk_size        = var.root_disk_size
  encrypted_disk_size   = var.encrypted_disk_size
  instance_name         = format("nginx-%s", count.index)
  security_group_id     = aws_security_group.web_sg.id
  instance_profile_name = aws_iam_instance_profile.ec2_web_profile.name
}


##SG
## create security group for web instances (public - open http port 80)
resource "aws_security_group" "web_sg" {
  name   = "web-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id[0]
}

resource "aws_security_group_rule" "web_http_acess" {
  description       = "allow http access from anywhere"
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.web_sg.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "web_ssh_acess" {
  description       = "allow ssh access from anywhere"
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.web_sg.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "web_outbound_anywhere" {
  description       = "allow outbound traffic to anywhere"
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.web_sg.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}





## OUTPUTS
output "instance_id" {
  value = module.web_instance[*].instance_id
}

output "instance_sg" {
  value = aws_security_group.web_sg.id
}
