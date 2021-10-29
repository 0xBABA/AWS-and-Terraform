output "instance_public_dns" {
  value = ["${aws_instance.web_instance.*.public_dns}"]
}

output "instance_public_ip" {
  value = ["${aws_instance.web_instance.*.public_ip}"]
}

output "instance_ids" {
  value = ["${aws_instance.web_instance.*.id}"]
}

output "instance_security_group" {
  value = ["${aws_security_group.web_sg.*.id}"]
}
