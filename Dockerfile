FROM ubuntu:17.10

RUN mkdir -p /app
WORKDIR /app

COPY scripts/ scripts/
COPY uninstall.sh scripts/uninstall.sh

RUN chmod +x scripts/*.sh
COPY my.bldr.env bldr.env

RUN apt-get update && apt-get install -y --no-install-recommends sudo curl ca-certificates dirmngr

#RUN gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
#RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.10/gosu-$(dpkg --print-architecture)" \
#    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.10/gosu-$(dpkg --print-architecture).asc" \
#    && gpg --verify /usr/local/bin/gosu.asc \
#    && rm /usr/local/bin/gosu.asc \
#    && chmod +x /usr/local/bin/gosu

ENTRYPOINT ["/app/scripts/entrypoint.sh"]
