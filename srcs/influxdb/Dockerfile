FROM influxdb:1.5-alpine

RUN wget --no-verbose https://dl.influxdata.com/telegraf/releases/telegraf-1.13.3-static_linux_amd64.tar.gz

RUN tar -C . -xzf telegraf-1.13.3-static_linux_amd64.tar.gz; \
	chmod +x telegraf/*; \
	cp telegraf/telegraf /usr/bin/; \
	rm -rf *.tar.gz* telegraf/

COPY telegraf_edit.conf /etc/telegraf/telegraf.conf

COPY start.sh /

EXPOSE 8086

ENTRYPOINT ["/entrypoint.sh"]
CMD sh start.sh
