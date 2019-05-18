.PHONY: build push

HUGO_VERSION=0.55.6

build:

	VERSION=0.55.6
	docker build -t alombarte/hugo --build-arg VERSION=${VERSION} .
	docker tag alombarte/hugo:latest alombarte/hugo:v${VERSION}

push:

	docker push alombarte/hugo:v${VERSION}
	docker push alombarte/hugo:latest
