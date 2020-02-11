FROM grafana/grafana

COPY dash_ftp.json /etc/grafana/provisioning/dashboards/
COPY dash_grafana.json /etc/grafana/provisioning/dashboards/
COPY dash_influxdb.json /etc/grafana/provisioning/dashboards/
COPY dash_mysql.json /etc/grafana/provisioning/dashboards/
COPY dash_nginx.json /etc/grafana/provisioning/dashboards/
COPY dash_pma.json /etc/grafana/provisioning/dashboards/
COPY dash_wp.json /etc/grafana/provisioning/dashboards/
COPY dash.yaml /etc/grafana/provisioning/dashboards/

USER root

RUN wget --no-verbose https://dl.influxdata.com/telegraf/releases/telegraf-1.13.3-static_linux_amd64.tar.gz

RUN tar -C . -xzf telegraf-1.13.3-static_linux_amd64.tar.gz; \
	chmod +x telegraf/*; \
	cp telegraf/telegraf /usr/bin/; \
	rm -rf *.tar.gz* telegraf/

COPY telegraf_edit.conf /etc/telegraf/telegraf.conf

CMD ["telegraf"]
