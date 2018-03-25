# Original Dockerfile for hypriot/rpi-alpine
#FROM arm32v6/alpine:3.6
#COPY tmp/qemu-arm-static /usr/bin/qemu-arm-static
FROM hypriot/rpi-alpine:3.6
LABEL maintainer="dev.windaflame@gmail.com" 

ARG HUGO
ENV ALPINE=3.6
LABEL version="alpine linux version: ${ALPINE}\r\nhugo version: ${HUGO}"
 
RUN echo "http://nl.alpinelinux.org/alpine/v${ALPINE}/main" > /etc/apk/repositories

RUN apk update && \
apk add openssh git && \
rm -rf /var/cache/apk/*

ADD content/hugo /usr/local/bin/hugo
WORKDIR /www/
ENTRYPOINT ["hugo"]
