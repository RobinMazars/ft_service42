minikube addons enable ingress

export KUB_IP=$(minikube ip)

eval $(minikube docker-env)

docker build -t custom-nginx srcs/nginx
docker build -t custom-mysql srcs/mysql
docker build -t custom-pma srcs/phpmyadmin
docker build -t custom-ftps srcs/ftps
docker build -t custom-wordpress srcs/wordpress

cp srcs/grafana.yaml srcs/grafana_edit.yaml
sed -i '' "s/_KUB_IP_/$KUB_IP/g" srcs/grafana_edit.yaml

kubectl apply -f srcs/ingress.yaml
kubectl apply -f srcs/nginx.yaml
kubectl apply -f srcs/mysql.yaml
kubectl apply -f srcs/phpmyadmin.yaml
kubectl apply -f srcs/ftps.yaml
kubectl apply -f srcs/grafana_edit.yaml
kubectl apply -f srcs/influxdb.yaml

minikube service wordpress --url
