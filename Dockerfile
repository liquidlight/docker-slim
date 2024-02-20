FROM docker:latest

LABEL org.opencontainers.image.source=https://github.com/liquidlight/docker-slim
LABEL org.opencontainers.image.description="Docker image containing docker-slim"
LABEL org.opencontainers.image.licenses=ISC

ARG DOCKER_SLIM_VERSION=1.40.11

RUN apk add \
	--update \
	--no-cache \
	curl

RUN curl -L -o ds.tar.gz https://downloads.dockerslim.com/releases/${DOCKER_SLIM_VERSION}/dist_linux.tar.gz \
	&& tar -xvf ds.tar.gz \
	&& mv dist_linux/slim /usr/local/bin/ \
	&& mv dist_linux/slim-sensor /usr/local/bin/
