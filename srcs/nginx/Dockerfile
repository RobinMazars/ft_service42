FROM    nginx:alpine

RUN     apk add openssh-server

COPY    index.html    /usr/share/nginx/html/
COPY    start.sh    ./
COPY    default.conf  /etc/nginx/conf.d/

COPY    certs/tls.crt  /etc/nginx/
COPY    certs/tls.key  /etc/nginx/

COPY    sshd_config /etc/ssh/sshd_config
COPY    certs/ssh_host_rsa_key /etc/ssh/ssh_host_rsa_key

RUN wget --no-verbose https://dl.influxdata.com/telegraf/releases/telegraf-1.13.3-static_linux_amd64.tar.gz

RUN tar -C . -xzf telegraf-1.13.3-static_linux_amd64.tar.gz; \
	chmod +x telegraf/*; \
	cp telegraf/telegraf /usr/bin/; \
	rm -rf *.tar.gz* telegraf/

COPY telegraf_edit.conf /etc/telegraf/telegraf.conf

RUN     chmod 600 etc/ssh/ssh_host_rsa_key
RUN     echo "root:toto" | chpasswd;

CMD     sh start.sh

EXPOSE  443 80 22
