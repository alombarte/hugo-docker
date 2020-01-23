.PHONY: build push

VERSION=0.62.2

build:

	docker build -t alombarte/hugo --build-arg VERSION=${VERSION} .
	docker tag alombarte/hugo:latest alombarte/hugo:v${VERSION}

push:

	docker push alombarte/hugo:v${VERSION}
	docker push alombarte/hugo:latest
