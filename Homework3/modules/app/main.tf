################################################
# Public Web Instances
################################################
resource "aws_instance" "web_instance" {
  count                       = var.web_instances_count
  ami                         = var.ami_id
  instance_type               = var.ec2_instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id[count.index]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
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
    Name = format("%s-${count.index}", var.instance_prefix)
  }
}

## create security group for web instances (public - open http port 80)
resource "aws_security_group" "web_sg" {
  name   = "web-sg"
  vpc_id = var.vpc_id
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
