FROM phpmyadmin/phpmyadmin:fpm-alpine

RUN apk update && \
	apk add nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint /entrypoint

RUN wget --no-verbose https://dl.influxdata.com/telegraf/releases/telegraf-1.13.3-static_linux_amd64.tar.gz

RUN tar -C . -xzf telegraf-1.13.3-static_linux_amd64.tar.gz; \
	chmod +x telegraf/*; \
	cp telegraf/telegraf /usr/bin/; \
	rm -rf *.tar.gz* telegraf/

COPY telegraf_edit.conf /etc/telegraf/telegraf.conf

ENTRYPOINT sh /entrypoint

CMD ["tail", "-F", "/var/log/nginx/access.log"]
