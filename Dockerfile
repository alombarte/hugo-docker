FROM alpine:3.8

ARG VERSION=0.53
ENV PACKAGE hugo_${VERSION}_Linux-64bit.tar.gz

RUN apk update && apk add \
	git\
	openssh\
	&& rm -rf /var/cache/apk/*

ADD https://github.com/gohugoio/hugo/releases/download/v${VERSION}/${PACKAGE} /tmp
RUN tar xzvf "/tmp/${PACKAGE}" hugo -C /usr/local/bin \
	&& rm -fr "/tmp/${PACKAGE}"

WORKDIR /site
VOLUME  /site
EXPOSE 1313
