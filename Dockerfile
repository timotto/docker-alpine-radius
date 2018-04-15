FROM alpine:3.7
LABEL maintainer="Tim Otto <tim@timotto.io>"
LABEL master="Marcel Maatkamp <m.maatkamp@gmail.com>"

WORKDIR /projects

RUN apk update && apk upgrade && \
    apk add --update freeradius freeradius-sqlite freeradius-radclient freeradius-eap sqlite openssl-dev && \
    chgrp radius  /usr/sbin/radiusd && chmod g+rwx /usr/sbin/radiusd && \
    rm /var/cache/apk/*

VOLUME /config

RUN ln -sf /config/server.pem /etc/raddb/certs/server.pem && \
    ln -sf /config/ca.pem /etc/raddb/certs/ca.pem && \
    ln -sf /config/dh /etc/raddb/certs/dh && \
    ln -sf /config/clients.conf /etc/raddb/clients.conf && \
    ln -sf /config/users /etc/raddb/mods-config/files/authorize

EXPOSE \
    1812/udp \
    1813/udp \
    18120

CMD ["radiusd","-xx","-f"]
