#!/bin/bash

LOCAL_TAG=mrs_uav_system:1.5.0
REGISTRY=klaxalk:5000

docker buildx use default

docker build . --file Dockerfile --tag $REGISTRY/$LOCAL_TAG --platform=linux/arm64 --push --no-cache --progress=plain
