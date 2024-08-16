#!/bin/bash

docker buildx build . --file Dockerfile --tag ctumrs/robofly:config --platform=linux/amd64,linux/arm64
