FROM docker:latest

ARG DOCKER_SLIM_VERSION=1.37.3

RUN apk add \
	--update \
	--no-cache \
	curl

RUN curl -L -o ds.tar.gz https://downloads.dockerslim.com/releases/${DOCKER_SLIM_VERSION}/dist_linux.tar.gz \
	&& tar -xvf ds.tar.gz \
	&& mv dist_linux/docker-slim /usr/local/bin/ \
	&& mv dist_linux/docker-slim-sensor /usr/local/bin/
