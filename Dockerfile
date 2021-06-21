FROM node:6-slim

ARG VERSION=3.2.1

MAINTAINER gluang

ENV TZ Asia/Shanghai

RUN apt-get update \
    && npm install --global gitbook-cli \
    && gitbook fetch ${VERSION} \
    && npm cache clear \
    && apt-get install -y --no-install-recommends calibre \
    && apt-get clean \
    && rm -rf /tmp/* /var/cache/* /usr/share/doc/* /usr/share/man/* /var/lib/apt/lists/*

WORKDIR /srv/gitbook

COPY font/* /usr/share/fonts/

EXPOSE 4000

CMD [ "bash" ]
