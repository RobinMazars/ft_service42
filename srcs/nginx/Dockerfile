FROM    nginx:alpine

RUN     apk add openssh-server

COPY    index.html    /usr/share/nginx/html/
COPY    start.sh    ./
COPY    default.conf  /etc/nginx/conf.d/

COPY    certs/tls.crt  /etc/nginx/
COPY    certs/tls.key  /etc/nginx/

COPY    sshd_config /etc/ssh/sshd_config
COPY    certs/ssh_host_rsa_key /etc/ssh/ssh_host_rsa_key

RUN     chmod 600 etc/ssh/ssh_host_rsa_key
RUN     echo "root:toto" | chpasswd;

CMD     sh start.sh

EXPOSE  443 80 22
