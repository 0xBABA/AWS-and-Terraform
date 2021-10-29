

module "web-instance" {
  source              = "../../../modules/app"
  web_instances_count = 2
  ami_id              = data.aws_ami.ubuntu-18.id
  key_name            = "yoad_opsschool_ec2-rsa"
  # subnet_id           = data.aws_subnet.get_subnet_info
  # subnet_id           = data.aws_subnet.get_subnet_info.*.id
  # subnet_id           = data.tf_vpc_state.public_subnets.outputs.public_subnet_id
  subnet_id           = [data.aws_subnet.get_subnet_info_0.id, data.aws_subnet.get_subnet_info_1.id]
  userdata_path       = var.userdata_path
  volumes_type        = var.volume_type
  root_disk_size      = var.root_disk_size
  encrypted_disk_size = var.encrypted_disk_size
  instance_prefix     = "nginx"
  vpc_id              = data.aws_vpc.get_vpc_info.id
}
