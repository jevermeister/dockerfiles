FROM node:lts-alpine

LABEL maintainer="Jevermeister"
LABEL source="https://github.com/jevermeister/hastebin-evo-docker"

ARG HASTEBIN_VER=dev

ENV UID=4242 GID=4242

RUN apk -U upgrade \
    && apk add git su-exec \
    && git clone https://github.com/jevermeister/hastebin-evo /app \
    && cd /app \
    && git checkout ${HASTEBIN_VER} \
    && npm install \
    && npm cache clean --force \
    && apk del git \
    && rm -rf /var/lib/apk/* /var/cache/apk/*

ADD ./app.sh /app/
RUN chmod 755 app.sh

EXPOSE 7777

ENV STORAGE_TYPE file

CMD [ "./app.sh" ]
