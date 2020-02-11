export KUB_IP=$(minikube ip)

eval $(minikube docker-env)

cp srcs/grafana.yaml srcs/grafana_edit.yaml
sed -i '' "s/_KUB_IP_/$KUB_IP/g" srcs/grafana_edit.yaml

cp srcs/nginx/telegraf.conf srcs/nginx/telegraf_edit.conf
sed -i '' "s/_KUB_IP_/$KUB_IP/g" srcs/nginx/telegraf_edit.conf

cp srcs/phpmyadmin/telegraf.conf srcs/phpmyadmin/telegraf_edit.conf
sed -i '' "s/_KUB_IP_/$KUB_IP/g" srcs/phpmyadmin/telegraf_edit.conf

cp srcs/wordpress/telegraf.conf srcs/wordpress/telegraf_edit.conf
sed -i '' "s/_KUB_IP_/$KUB_IP/g" srcs/wordpress/telegraf_edit.conf

cp srcs/grafana/telegraf.conf srcs/grafana/telegraf_edit.conf
sed -i '' "s/_KUB_IP_/$KUB_IP/g" srcs/grafana/telegraf_edit.conf

cp srcs/ftps/telegraf.conf srcs/ftps/telegraf_edit.conf
sed -i '' "s/_KUB_IP_/$KUB_IP/g" srcs/ftps/telegraf_edit.conf

cp srcs/mysql/telegraf.conf srcs/mysql/telegraf_edit.conf
sed -i '' "s/_KUB_IP_/$KUB_IP/g" srcs/mysql/telegraf_edit.conf

docker build -t custom-nginx srcs/nginx
docker build -t custom-mysql srcs/mysql
docker build -t custom-pma srcs/phpmyadmin
docker build --build-arg KUB_IP=$KUB_IP -t custom-ftps srcs/ftps
docker build -t custom-wordpress srcs/wordpress
docker build -t custom-grafana srcs/grafana
