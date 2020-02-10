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

docker build -t custom-nginx srcs/nginx
docker build -t custom-mysql srcs/mysql
docker build -t custom-pma srcs/phpmyadmin
docker build -t custom-ftps srcs/ftps
docker build -t custom-wordpress srcs/wordpress

kubectl apply -f srcs/ingress.yaml
kubectl apply -f srcs/nginx.yaml
kubectl apply -f srcs/mysql.yaml
kubectl apply -f srcs/phpmyadmin.yaml
kubectl apply -f srcs/ftps.yaml
kubectl apply -f srcs/grafana_edit.yaml
kubectl apply -f srcs/influxdb.yaml
kubectl apply -f srcs/wordpress.yaml

minikube service wordpress --url
