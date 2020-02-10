#!/bin/sh

apk update

apk add openssl --no-cache
apk add pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

# ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem \
-subj "/C=FR/ST=Rhone/L=Lyon/O=42/OU=42/CN=tmarcon/emailAddress=tmarcon@student.le-101.fr"

adduser -D "admin"
echo "admin:admin" | chpasswd

touch /home/admin/hello.txt
echo "Welcome to my ftp server" > /home/admin/hello.txt
