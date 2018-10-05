# Hugo docker

An alpine docker image with hugo, openssh and git. Used in my CI pipelines.

It comes without the `hugo` entrypoint.

Usage
-----

To build your hugo site in the default `public` directory:

	docker run -v "${PWD}:/site" alombarte/hugo hugo

