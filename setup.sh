minikube start --cpus=4 --memory 5000 --disk-size 11000 --vm-driver virtualbox --extra-config=apiserver.service-node-port-range=1-35000

minikube addons enable ingress

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

cp srcs/influxdb/telegraf.conf srcs/influxdb/telegraf_edit.conf
sed -i '' "s/_KUB_IP_/$KUB_IP/g" srcs/influxdb/telegraf_edit.conf

cp srcs/mysql/telegraf.conf srcs/mysql/telegraf_edit.conf
sed -i '' "s/_KUB_IP_/$KUB_IP/g" srcs/mysql/telegraf_edit.conf

cp srcs/wordpress/wordpress-sample.sql srcs/wordpress/wordpress.sql
sed -i '' "s/_KUB_IP_/$KUB_IP/g" srcs/wordpress/wordpress.sql

docker build -t custom-nginx srcs/nginx
docker build -t custom-mysql srcs/mysql
docker build -t custom-pma srcs/phpmyadmin
docker build --build-arg KUB_IP=$KUB_IP -t custom-ftps srcs/ftps
docker build -t custom-wordpress srcs/wordpress
docker build -t custom-grafana srcs/grafana
docker build -t custom-influxdb srcs/influxdb

kubectl apply -f srcs/ingress.yaml
kubectl apply -f srcs/nginx.yaml
kubectl apply -f srcs/mysql.yaml
kubectl apply -f srcs/phpmyadmin.yaml
kubectl apply -f srcs/ftps.yaml
kubectl apply -f srcs/grafana_edit.yaml
kubectl apply -f srcs/influxdb.yaml
kubectl apply -f srcs/wordpress.yaml

minikube service wordpress --url
