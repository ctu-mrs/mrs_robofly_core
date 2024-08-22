#!/bin/bash

LOCAL_TAG=robofly:shared_data
REGISTRY=localhost:5000

docker build . --file Dockerfile --tag ctumrs/robofly:shared_data

docker push "$REGISTRY/$LOCAL_TAG"
