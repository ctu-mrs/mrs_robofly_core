#!/bin/bash

docker buildx create --name container --driver=docker-container
docker buildx build . --file Dockerfile --tag ctumrs/robofly:config --platform=linux/arm64
