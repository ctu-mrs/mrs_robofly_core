#!/bin/bash

LOCAL_TAG=robofly:custom_package
REGISTRY=fly4future

docker build . --file Dockerfile --tag $REGISTRY/$LOCAL_TAG --no-cache --progress=plain

# docker push $REGISTRY/$LOCAL_TAG
