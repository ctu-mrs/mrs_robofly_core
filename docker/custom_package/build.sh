#!/bin/bash

LOCAL_TAG=robofly:custom_package

ARCH=arm64
# ARCH=amd64

WORKSPACE_PATH=etc/catkin_workspace
CACHE_PATH=cache

# initialize the cache
mkdir -p ./${CACHE_PATH}/${WORKSPACE_PATH}

# this first build compiles the contents of "src" and storest the intermediate
docker build . --target stage_cache_workspace --output ./${CACHE_PATH} --build-arg WORKSPACE_PATH=${WORKSPACE_PATH} --file Dockerfile --platform=linux/arm64

# this second build takes the resulting workspace and storest in in a final image
# that can be deployed to a drone
docker build . --target stage_finalization --file Dockerfile --build-arg WORKSPACE_PATH=${WORKSPACE_PATH} --tag $LOCAL_TAG --platform=linux/arm64
