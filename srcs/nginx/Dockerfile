FROM    nginx:alpine

RUN     apk add openssh

COPY    index.html    /usr/share/nginx/html/
COPY    default.conf  /etc/nginx/conf.d/

COPY    certs/tls.crt  /etc/nginx/
COPY    certs/tls.key  /etc/nginx/

COPY    certs/ssh  /etc/ssh/ssh_host_rsa_key
COPY    certs/ssh  /etc/ssh/ssh_host_ed25519_key

EXPOSE  443 80 22
