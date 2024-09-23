#!/bin/bash

LOCAL_TAG=uav_configs:robofly_00001
REGISTRY=fly4future

docker buildx create --name container --driver=docker-container
docker buildx build . --file Dockerfile --tag "$REGISTRY/$LOCAL_TAG" --platform=linux/arm64

docker push "$REGISTRY/$LOCAL_TAG"
