
Under Kubernetes
Under ALPIN LINUX
-> Cluster = Regroupement container de service
Name container = SERVICE

SERVICES :
-> dashboard Kuber -> gerer cluster
LINK --> https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/

-> Ingress Controller -> qui gère l’accès externe aux services dans un cluster. C’est lui qui va rediriger vers votre Container Nginx.
LINK -->  https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/

-> Nginx -> ports 80 et 443.
LINK -->

-> serveur FTPS -> port 21.
LINK -->  https://www.goanywhere.com/fr/blog/sftp-ou-ftps-les-differences-essentielles
          https://buddy.works/actions/ftps/
          https://github.com/delfer/docker-alpine-ftp-server

-> wordpress -> port 5050, base de donnée Mysql. deux containers distincts. wordpress : plusieurs utilisateurs & administrateur.

-> Phpmyadmin -> port 5000 et relié a la base de donnée MySQL.

-> Un grafana -> port 3000 -> base de donnée influxDB -> monitorer tous vos containers. deux containers distincts. dashboard par container.
LINK -->  https://grafana.com/grafana/dashboards/1150
          https://hub.docker.com/r/grafana/grafana/
          https://hub.docker.com/_/influxdb


-> En cas de crash ou d’arrêt d’un des deux containers de base de données, vous devrez vous assurer que celles-ci puissent persister et ne soient pas perdu. En cas de suppression, les volumes où la data est sauvegardée doivent persister.
LINK -->  https://kubernetes.io/fr/docs/concepts/workloads/controllers/replicaset/

-> Nginx en connexion SSH.
LINK -->  https://www.howtoforge.com/reverse-proxy-for-https-ssh-and-mysql-mariadb-using-nginx/
