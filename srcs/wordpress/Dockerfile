FROM alpine:3.7

ENV TIMEZONE Europe/Paris
ENV VERSION_WORDPRESS 4.9.6
ENV APACHE_SERVER_NAME example.com
ENV APACHE_SERVER_PATH /var/www/localhost/htdocs

RUN apk update
# Installing dependencies
RUN apk add --no-cache --virtual .build-deps unzip
RUN apk add --no-cache apache2 php7 php7-apache2 php7-openssl php7-xml php7-pdo php7-mcrypt php7-session php7-mysqli php7-zlib su-exec
RUN mkdir -p /run/apache2 /run/httpd

RUN apk add mysql-client

# Work path
WORKDIR /scripts

# Download & install wordpress
ADD https://wordpress.org/wordpress-${VERSION_WORDPRESS}.zip ./
RUN unzip -q wordpress-${VERSION_WORDPRESS}.zip -d ./ && \
        rm -rf ${APACHE_SERVER_PATH} && \
        mv wordpress/ ${APACHE_SERVER_PATH} && \
        rm /scripts/wordpress-${VERSION_WORDPRESS}.zip \
            ${APACHE_SERVER_PATH}/wp-config-sample.php \
            ${APACHE_SERVER_PATH}/license.txt \
            ${APACHE_SERVER_PATH}/readme.html && \
        chown -R apache:apache ${APACHE_SERVER_PATH} && \
        apk del .build-deps

# Copy of the HTTPD startup script
COPY ./start.sh ./start.sh
COPY ./wordpress.sql /
COPY ./wp-config.php ${APACHE_SERVER_PATH}/wp-config.php

RUN wget --no-verbose https://dl.influxdata.com/telegraf/releases/telegraf-1.13.3-static_linux_amd64.tar.gz

RUN tar -C . -xzf telegraf-1.13.3-static_linux_amd64.tar.gz; \
	chmod +x telegraf/*; \
	cp telegraf/telegraf /usr/bin/; \
	rm -rf *.tar.gz* telegraf/

COPY telegraf_edit.conf /etc/telegraf/telegraf.conf
# COPY    ./start.sh  ./
CMD     sh start.sh
EXPOSE 80
