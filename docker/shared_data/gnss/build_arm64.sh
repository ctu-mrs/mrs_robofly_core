#!/bin/bash

# LOCAL_TAG=robofly:shared_data_gnss
# REGISTRY=localhost:5000

LOCAL_TAG=robofly:shared_data_gnss
REGISTRY=fly4future

docker buildx create --name container --driver=docker-container
docker buildx build . --file Dockerfile --tag "$REGISTRY/$LOCAL_TAG" --platform=linux/arm64

docker push "$REGISTRY/$LOCAL_TAG"

# docker save "$REGISTRY/$LOCAL_TAG" --output $LOCAL_TAG.tar
