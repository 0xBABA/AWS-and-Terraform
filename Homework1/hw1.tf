##################################################################################
# VARIABLES
##################################################################################

variable "private_key_path" {}
variable "key_name" {}
variable "region" {
  default = "us-east-1"
}

variable "userdata_path" {}

##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  region = var.region
}

##################################################################################
# DATA
##################################################################################

data "aws_ami" "aws-linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


##################################################################################
# RESOURCES
##################################################################################

#This uses the default VPC.  It WILL NOT delete it on destroy.
resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "allow_ssh" {
  name        = "opsschool-hw1-nginx"
  description = "Allow ports for nginx"
  vpc_id      = aws_default_vpc.default.id

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

resource "aws_ebs_volume" "opsschool-hw1-ebs1" {
  availability_zone = "us-east-1a"
  size              = 10
  type              = "gp2"
  encrypted         = "true"

  tags = {
    Name = "hw1-ebs1"
  }
}

resource "aws_instance" "opsschool-hw1-nginx1" {
  ami                    = data.aws_ami.aws-linux.id
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1a"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
  }

  tags = {
    owner   = "yoad"
    Name    = "hw1_nginx1"
    purpose = "whiskey"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install nginx -y",
      "echo \"<h1>Welcome to Grandpa's Whiskey</h1>\" | sudo tee /usr/share/nginx/html/index.html",
      "sudo service nginx start"
    ]
  }
}

resource "aws_volume_attachment" "opsschool-hw1-ebs1-attach" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.opsschool-hw1-ebs1.id
  instance_id = aws_instance.opsschool-hw1-nginx1.id
}

resource "aws_instance" "opsschool-hw1-nginx2" {
  ami                    = data.aws_ami.aws-linux.id
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1a"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    owner   = "yoad"
    Name    = "hw1_nginx2"
    purpose = "whiskey"
  }

  #create an ebs volume
  ebs_block_device {
    device_name           = "/dev/sdg"
    volume_size           = 10
    volume_type           = "gp2"
    delete_on_termination = true
    encrypted             = "true"
    tags = {
      Name = "hw1-ebs2"
    }
  }

  #run userdata script
  user_data = file(var.userdata_path)
}


##################################################################################
# OUTPUT
##################################################################################

output "aws_instance1_public_dns" {
  value = aws_instance.opsschool-hw1-nginx1.public_dns
}
output "aws_instance2_public_dns" {
  value = aws_instance.opsschool-hw1-nginx2.public_dns
}
