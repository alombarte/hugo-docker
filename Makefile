.PHONY: build push

# Pass the version during the build and push:
# make VERSION=0.81.0 build
VERSION=xxx

build:

	docker build -t alombarte/hugo --build-arg VERSION=${VERSION} .
	docker tag alombarte/hugo:latest alombarte/hugo:v${VERSION}

push:

	docker push alombarte/hugo:v${VERSION}
	docker push alombarte/hugo:latest
