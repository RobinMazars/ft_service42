FROM alpine:3.10.3

RUN apk add mysql mysql-client

COPY my.cnf /etc/mysql/my.cnf
COPY start.sh /start.sh

RUN mkdir /app

EXPOSE 3306

CMD sh /start.sh
