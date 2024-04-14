#!/bin/bash 
yum update –y 
yum install nginx -y
systemctl start nginx
systemctl enable nginx
echo "<h3> Welcome to my NGINX web server! User data instillation was a SUCCESS! </h3>" > /usr/share/nginx/html/index.html
