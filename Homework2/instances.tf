############
# Instances
############
resource "aws_instance" "hw2_web_instance" {
  count                       = 2
  ami                         = data.aws_ami.ubuntu-18.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.hw2_pub_sn.*.id[count.index]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.hw2_nginx_sg.id]
  user_data                   = file(var.userdata_path)

  root_block_device {
    encrypted   = false
    volume_type = "gp2"
    volume_size = var.root_disk_size
  }

  tags = {
    Name = "hw2_web_instance-${count.index + 1}"
  }
}

## create security group for web instances (public - open http port 80)
resource "aws_security_group" "hw2_nginx_sg" {
  name        = "hw2_nginx_sg"
  description = "Allow ports for nginx web intances"
  vpc_id      = aws_vpc.hw2_main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}


output "hw2_web_instance_public_dns" {
  value = ["${aws_instance.hw2_web_instance.*.public_dns}"]
}
output "hw2_web_instance_public_ip" {
  value = ["${aws_instance.hw2_web_instance.*.public_ip}"]
}
