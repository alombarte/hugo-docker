# Hugo docker

An alpine docker image with hugo, openssh and git. Used in my CI pipelines.

It comes without the `hugo` entrypoint.

Usage
-----

To build your hugo site in the default `public` directory:

	docker run -v "${PWD}:/site" alombarte/hugo hugo

## Use a different hugo version
Available versions are [here](https://hub.docker.com/r/alombarte/hugo/tags). To add another version just build the image passing the desired version, e.g.:

	VERSION=0.53 docker build -t alombarte/hugo:${VERSION} --build-arg VERSION=${VERSION} .

