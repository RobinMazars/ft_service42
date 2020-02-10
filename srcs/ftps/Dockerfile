FROM alpine

ARG KUB_IP
ENV MY_IP $KUB_IP

COPY start.sh /
RUN sh start.sh

EXPOSE 21 21000

CMD ["/bin/sh", "-c", "pure-ftpd -j -Y 2 -p 21000:21000 -P ${MY_IP}"]
