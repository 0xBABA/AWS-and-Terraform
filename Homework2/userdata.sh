#!/bin/bash

# set -x
# exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1

sudo apt update -y
sudo apt install nginx -y
echo "<h1>Welcome to Grandpa's Whiskey</h1>" | sudo tee /var/www/html/index.nginx-debian.html
sudo service nginx restart