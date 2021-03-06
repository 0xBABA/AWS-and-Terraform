#!/bin/bash

# set -x
# exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1

sudo apt update -y
sudo apt install nginx awscli -y

# Welcome page changes
echo "<h1>Welcome to Grandpa's Whiskey</h1><h2>I am `hostname` and I will be your host</h2>" | sudo tee /var/www/html/index.nginx-debian.html

# Change Nginx configuration to get real user’s IP address in Nginx log files-
echo "set_real_ip_from  ${module.vpc_module.vpc_cidr};" >> /etc/nginx/conf.d/default.conf; echo "real_ip_header    X-Forwarded-For;" >> /etc/nginx/conf.d/default.conf

sudo service nginx restart

# Upload web server access logs to S3 every hour
crontab<<EOF
$(crontab -l)
0 * * * * aws s3 cp /var/log/nginx/access.log s3://yoad-opsschool-aws-tf-hw3-access-logs/\`hostname\`--\`date +"\%Y-\%m-\%d_\%H:\%M:\%S"\`
EOF