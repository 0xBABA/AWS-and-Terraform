################################################
# Private "DB" Instances
################################################
## creating the private db instances
resource "aws_instance" "db_instance" {
  count                       = var.db_instances_count
  ami                         = data.aws_ami.ubuntu-18.id
  instance_type               = var.ec2_instance_type
  key_name                    = var.key_name
  subnet_id                   = data.aws_subnets.get_subnets_info.ids[count.index]
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.db_sg.id]

  root_block_device {
    encrypted   = false
    volume_type = var.volumes_type
    volume_size = var.root_disk_size
  }

  tags = {
    Name = format("%s-${count.index + 1}", var.instance_prefix)
  }
}

## create security group for db instances (private - should not have open http port 80, keeping it open for testing)
resource "aws_security_group" "db_sg" {
  name        = "db-sg"
  description = "Allow ports for db intances"
  vpc_id      = data.aws_vpc.get_vpc_info.id
}

resource "aws_security_group_rule" "db_ssh_acess" {
  description       = "allow ssh access from anywhere"
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.db_sg.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "db_outbound_anywhere" {
  description       = "allow outbound traffic to anywhere"
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.db_sg.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}
