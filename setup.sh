minikube start --cpus=4 --memory 4000 --disk-size 11000 --vm-driver virtualbox --extra-config=apiserver.service-node-port-range=1-35000

minikube addons enable ingress

export KUB_IP=$(minikube ip)

eval $(minikube docker-env)

docker build -t custom-nginx srcs/nginx
docker build -t custom-mysql srcs/mysql
docker build -t custom-pma srcs/phpmyadmin
docker build -t custom-ftps srcs/ftps
docker build -t custom-grafana srcs/grafana
docker build -t custom-wordpress srcs/wordpress

kubectl apply -f ingress.yaml

kubectl apply -f nginx.yaml
kubectl apply -f mysql.yaml
kubectl apply -f phpmyadmin.yaml
kubectl apply -f ftps.yaml
kubectl apply -f grafana.yaml
kubectl apply -f influxdb.yaml

minikube service wordpress --url
