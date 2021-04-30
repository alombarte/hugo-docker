# Hugo docker

An alpine docker image with hugo, node (for pipeline functionality), openssh and git. Used in my CI pipelines.

It comes without the `hugo` entrypoint.

Usage
-----

To build your hugo site in the default `public` directory:

	docker run -v "${PWD}:/site" alombarte/hugo hugo

## Use a different hugo version

Available versions are [here](https://hub.docker.com/r/alombarte/hugo/tags). To add another version just build the image passing the desired version, e.g.:

    export VERSION=0.55.6 && docker build -t alombarte/hugo:${VERSION} --build-arg VERSION=${VERSION} .

## Integration on Gitlab and Github
The following file is an example on how to build a hugo site hosetd on a private repo (Gitlab) and deploy it into a public Github repo (the generated HTML). Yes, you could the whole thing on Gitlab :)

Make sure to set the variables in the configuration:

- $USERNAME
- $REPOSITORY
- $EMAIL
- $GH_TOKEN (the token provided by github so you can push without your password)


```
image: alombarte/hugo

stages:
  - build
  - deploy
services:
  - docker:dind

# If you need special NPM builds that cannot be handled through Hugo:
build:
  stage: build
  image: docker:stable
  script:
    - docker run -v $PWD:/app -w /app node:10 npm install
    - docker run -v $PWD:/app -w /app node:10 npm run-script build
  artifacts:
    paths:
    - static/dist/
  only:
    - master

deploy:
  stage: deploy
# variables:
#    GIT_SUBMODULE_STRATEGY: normal
#    GIT_DEPTH: "3"
  dependencies:
    - build
  script:
    - git clone https://github.com/${USERNAME}/${REPOSITORY}.git public
    - rm -fr public/*
    - hugo -d public
    - cd public
    - git remote rm origin
    - git remote add origin https://${USERNAME}:${GH_TOKEN}@github.com/${USERNAME}/${REPOSITORY}.net.git
    - git config --global user.email "${EMAIL}"
    - git config --global user.name "${USERNAME}"
    - git add -A
    - git commit -m "Automatic build from CI $CI_SERVER_NAME $CI_PIPELINE_ID"
    - git push --set-upstream origin master
  artifacts:
    paths:
    - public
  only:
    - master
  before_script:
    - hugo version
```
