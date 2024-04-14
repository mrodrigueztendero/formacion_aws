#!/bin/bash 
dnf update -y 
dnf install nginx -y
systemctl start nginx
systemctl enable nginx
echo "<h2> Welcome to my NGINX web server!</h2> <h3>User data instillation was a SUCCESS! </h3>" > /usr/share/nginx/html/index.html
