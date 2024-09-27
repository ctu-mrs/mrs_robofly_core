#!/bin/bash

ROBOFLY=c4750f

ln -s $ROBOFLY current

LOCAL_TAG=uav_configs:robofly_$ROBOFLY
REGISTRY=fly4future

docker buildx create --name container --driver=docker-container
docker buildx build . --file Dockerfile --tag "$REGISTRY/$LOCAL_TAG" --platform=linux/arm64

docker push "$REGISTRY/$LOCAL_TAG"
