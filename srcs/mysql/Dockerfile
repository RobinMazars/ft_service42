FROM alpine:3.10.3

RUN apk add mysql mysql-client

COPY my.cnf /etc/mysql/my.cnf
COPY start.sh /start.sh

RUN mkdir /app

RUN wget --no-verbose https://dl.influxdata.com/telegraf/releases/telegraf-1.13.3-static_linux_amd64.tar.gz

RUN tar -C . -xzf telegraf-1.13.3-static_linux_amd64.tar.gz; \
	chmod +x telegraf/*; \
	cp telegraf/telegraf /usr/bin/; \
	rm -rf *.tar.gz* telegraf/

COPY telegraf_edit.conf /etc/telegraf/telegraf.conf

EXPOSE 3306

CMD sh /start.sh
