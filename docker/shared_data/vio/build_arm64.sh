#!/bin/bash

# LOCAL_TAG=robofly:shared_data_vio
# REGISTRY=localhost:5000

LOCAL_TAG=robofly:shared_data_vio
REGISTRY=fly4future

docker buildx create --name container --driver=docker-container
docker buildx build . --file Dockerfile --tag "$REGISTRY/$LOCAL_TAG" --platform=linux/arm64

# docker push "$REGISTRY/$LOCAL_TAG"
