minikube start --cpus=4 --memory 4000 --disk-size 11000 --vm-driver virtualbox --extra-config=apiserver.service-node-port-range=1-35000

minikube addons enable ingress

export KUB_IP=$(minikube ip)

eval $(minikube docker-env)

docker build -t custom-nginx:1.11 srcs/nginx
docker build -t custom-grafana srcs/grafana

kubectl apply -f ingress.yaml
kubectl apply -f nginx.yaml
kubectl apply -f grafana.yaml
kubectl apply -k ./
minikube service wordpress --url
