# HW-1 notes
* Created 2 t2.micro instances according to clarification in slack channel
* For each I used different ebs and nginx methods:

  * **opsschool-hw1-nginx1:** For this server I used a provisioner for nginx installation and attached an ebs volume which was created with an aws_ebs_volume + aws_volume_attachment resources.

  * **opsschool-hw1-nginx2:** For this I used a userdata script to install nginx and the ebs volume was created and attached by utilizing the ebs_block_device argument inside the aws_instance resource block.

* provisioining was done from a role assigned EC2 dev machine - so no user credentials were used within the TF configuration.