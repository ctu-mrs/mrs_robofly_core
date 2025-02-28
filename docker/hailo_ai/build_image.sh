#!/bin/bash

# get the path to this script
MY_PATH=`dirname "$0"`
MY_PATH=`( cd "$MY_PATH" && pwd )`

cd ${MY_PATH}

## --------------------------------------------------------------
## |                            setup                           |
## --------------------------------------------------------------

LOCAL_TAG=mrs_uav_system:1.5.0_hailo_ai
REGISTRY=ctumrs

# single-platform image can be stored locally
# ARCH=linux/amd64
ARCH=linux/arm64
OUTPUT="--output type=docker"

# multi-platform image can not be stored locally, needs to be pushed
# ARCH=linux/arm64,linux/amd64
# OUTPUT="--push"

## --------------------------------------------------------------
## |                            build                           |
## --------------------------------------------------------------

# multiplatform builder
BUILDER=container-builder

# get info about an existing builder
container_builder_info=$(docker buildx inspect ${BUILDER})

if [[ "$?" == "0" ]]; then
  # activate the builder if it exists
  docker buildx use ${BUILDER}
else
  # create the builder if it does not exist
  docker buildx create --name ${BUILDER} --driver docker-container --bootstrap --use
fi

# build the docker image using the builder and export the results to the local docker registry
docker buildx build . --file Dockerfile --tag $REGISTRY/$LOCAL_TAG --platform=${ARCH} ${OUTPUT}

echo ""
echo "$0: shared data were packed into '$LOCAL_TAG'"
echo ""
