#!/bin/bash 
yum update –y 
amazon-linux-extras install nginx1.12
nginx -v
systemctl start nginx
systemctl enable nginx
chmod 2775 /usr/share/nginx/html 
find /usr/share/nginx/html -type d -exec chmod 2775 {} \;
find /usr/share/nginx/html -type f -exec chmod 0664 {} \;
echo "<h3> Welcome to my NGINX web server! User data instillation was a SUCCESS! </h3>" > /usr/share/nginx/html/index.html