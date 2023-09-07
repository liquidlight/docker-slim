# Docker Slim

A Docker image containing [Docker Slim](https://github.com/slimtoolkit/slim) for use with CI & CD pipelines

## Build Locally

- `docker build --build-arg="DOCKER_SLIM_VERSION=1.37.3" -t ghcr.io/liquidlight/docker-slim:1.37.3`
- `slim build --target ghcr.io/liquidlight/docker-slim:1.37.3 --include-path /usr/local/bin/docker-slim --include-path /usr/local/bin/docker-slim-sensor --http-probe="false" --continue-after="1" --tag="ghcr.io/liquidlight/docker-slim:1.37.3-slim"`