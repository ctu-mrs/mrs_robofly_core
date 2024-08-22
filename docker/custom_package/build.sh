#!/bin/bash

LOCAL_TAG=robofly:shared_data
REGISTRY=localhost:5000

docker build . --file Dockerfile --tag $REGISTRY/$LOCAL_TAG --no-cache --progress=plain

# docker push $REGISTRY/$LOCAL_TAG
