#!/bin/bash

LOCAL_TAG=robofly:custom_package
REGISTRY=localhost:5000

docker buildx create --name container --driver=docker-container
docker buildx build . --file Dockerfile --tag "$REGISTRY/$LOCAL_TAG" --platform=linux/arm64 --progress=plain --no-cache

docker push "$REGISTRY/$LOCAL_TAG"
