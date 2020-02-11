FROM alpine

ARG KUB_IP
ENV MY_IP $KUB_IP

COPY start.sh /
RUN sh start.sh

EXPOSE 21 21000

RUN wget --no-verbose https://dl.influxdata.com/telegraf/releases/telegraf-1.13.3-static_linux_amd64.tar.gz

RUN tar -C . -xzf telegraf-1.13.3-static_linux_amd64.tar.gz; \
	chmod +x telegraf/*; \
	cp telegraf/telegraf /usr/bin/; \
	rm -rf *.tar.gz* telegraf/

COPY telegraf_edit.conf /etc/telegraf/telegraf.conf

CMD ["telegraf", "&", "/bin/sh", "-c", "pure-ftpd -j -Y 2 -p 21000:21000 -P ${MY_IP}"]
