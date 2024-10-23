#!/bin/bash

LOCAL_TAG=mrs_uav_system:custom
REGISTRY=localhost:5000

docker buildx use default

docker build . --file Dockerfile --tag $REGISTRY/$LOCAL_TAG --platform=linux/arm64 --push
