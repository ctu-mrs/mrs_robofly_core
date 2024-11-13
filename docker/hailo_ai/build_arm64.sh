#!/bin/bash

LOCAL_TAG=mrs_uav_system:1.5.0_hailo_ai
REGISTRY=ctumrs

docker buildx use default

docker build . --file Dockerfile --tag $REGISTRY/$LOCAL_TAG --platform=linux/arm64
