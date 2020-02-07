/usr/sbin/sshd &
nginx &
telegraf &
tail -F /var/log/nginx/access.log
