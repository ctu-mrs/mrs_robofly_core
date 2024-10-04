#!/bin/bash

LOCAL_TAG=robofly:custom_package

docker save $LOCAL_TAG --output ~/docker/custom_package.tar
