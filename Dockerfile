FROM alpine:edge
LABEL maintainer="Tim Otto <tim@timotto.io>"
LABEL master="Marcel Maatkamp <m.maatkamp@gmail.com>"

WORKDIR /projects

RUN apk update && apk upgrade && \
    apk add --update freeradius freeradius-sqlite freeradius-radclient sqlite openssl-dev && \
    chgrp radius  /usr/sbin/radiusd && chmod g+rwx /usr/sbin/radiusd && \
    rm /var/cache/apk/*

VOLUME \
    /opt/db/ \
    /etc/freeradius/certs

EXPOSE \
    1812/udp \
    1813/udp \
    18120

CMD ["radiusd","-xx","-f"]
