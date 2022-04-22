FROM geotekne/gdal:2.1.4-alpine
LABEL maintainer="geotekne.argentina@gmail.com"

#
# INSTALL SSH Server in order to allow access as GDAL worker
# https://www.cyberciti.biz/faq/how-to-install-openssh-server-on-alpine-linux-including-docker/
# and necessary commands/tools (CURL, date, etc)

RUN apk add --update --no-cache openssh curl coreutils && rm -rf /var/cache/apk/*
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
RUN adduser -h /home/worker -s /bin/sh -D worker
RUN echo -n 'worker:worker' | chpasswd

ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 22
COPY entrypoint.sh /
