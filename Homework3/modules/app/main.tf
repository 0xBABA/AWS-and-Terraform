################################################
# Public Web Instances
################################################
resource "aws_instance" "web_instance" {
  ami                         = var.ami_id
  instance_type               = var.ec2_instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.security_group_id]
  user_data                   = file(var.userdata_path)

  root_block_device {
    encrypted   = false
    volume_type = var.volumes_type
    volume_size = var.root_disk_size
  }

  ebs_block_device {
    encrypted   = true
    device_name = var.encrypted_disk_device_name
    volume_type = var.volumes_type
    volume_size = var.encrypted_disk_size
  }

  tags = {
    Name = format("%s", var.instance_name)
  }
}

