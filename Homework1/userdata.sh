#!/bin/bash

sudo yum install nginx -y
echo "<h1>Welcome to Grandpa's Whiskey</h1>" | sudo tee /usr/share/nginx/html/index.html
sudo service nginx start