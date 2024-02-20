# Docker Slim

**Status**: [![Create and publish a Docker image](https://github.com/liquidlight/docker-slim/actions/workflows/push-docker-image.yml/badge.svg)](https://github.com/liquidlight/docker-slim/actions/workflows/push-docker-image.yml)

A Docker image containing [Docker Slim](https://github.com/slimtoolkit/slim) for use with CI & CD pipelines.

[Installing Docker Slim](https://github.com/slimtoolkit/slim#installation) is noted as a series of commands which xan be run as part of your pipeline. However, to save resources, time and a point of failure (if the machine at the time cannot execute the `curl` command) we thought it efficient to have it packaged ready to go.

## Usage

This image is designed to be used as the base image for a job within a CI/CD pipeline.

We only have experience with Gitlab and Github, so PRs with examples for other tools would be appreciated.

### Gitlab

It is worth running `docker-slim` locally to ensure you get the parameters you need, some useful ones i've found:

- `--http-probe="false"` combined with `--continue-after="1"` is handy if your docker image doesn't expose ports
- `--include-path="/usr/local/bin/docker-slim"` - makes sure your custom scripts or files & folders are definitely included

```yaml
slim:image:build:
  # Use the image with built-in docker slim
  image: ghcr.io/liquidlight/docker-slim:1.40.11
  # Specify input and output names
  variables:
    IMAGE_NAME: "$CI_REGISTRY_IMAGE:$CI_COMMIT_BRANCH"
    SLIM_IMAGE_NAME: "$IMAGE_NAME-slim"
  # Login to the registry
  before_script:
    # Login to our registry
    - echo "$CI_REGISTRY_PASSWORD" | docker login $CI_REGISTRY --username $CI_REGISTRY_USER --password-stdin
  script:
    # Ensure that the fat image is cached locally
    - docker pull $IMAGE_NAME
    # Note regarding parameters: "--target" is the input, "--tag" is the output
    - >
      docker-slim build
      --target="$IMAGE_NAME"
      --tag="$SLIM_IMAGE_NAME"

    # Push the slimmer image
    - docker push $SLIM_IMAGE_NAME
```

## Github

_Note:_ We haven't properly worked out how to use our image on Github Actions, so for now, the [Docker Slim GitHub Action](https://github.com/marketplace/actions/docker-slim-github-action) is available.

There is an example [in this very repository](https://github.com/liquidlight/docker-slim/blob/main/.github/workflows/push-docker-image.yml).

```yaml
- name: Make a Slim image
  uses: kitabisa/docker-slim-action@v1
  env:
    DSLIM_HTTP_PROBE: false
  with:
    target: ${{ env.IMAGE_NAME }}
    tag: "${{ env.DOCKER_SLIM_VERSION }}-slim"

  # Push to the registry
  - run: docker push ${{ env.IMAGE_NAME }}-slim
```
