#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

# get the path to this script
MY_PATH=`dirname "$0"`
MY_PATH=`( cd "$MY_PATH" && pwd )`

cd ${MY_PATH}

## --------------------------------------------------------------
## |                            setup                           |
## --------------------------------------------------------------

LOCAL_TAG=user_workspace:1.0.0
EXPORT_PATH=~/docker

## --------------------------------------------------------------
## |                           export                           |
## --------------------------------------------------------------

docker save ${LOCAL_TAG} | gzip > ${EXPORT_PATH}/${LOCAL_TAG}.tar.gz

echo ""
echo "$0: image exorted as ${EXPORT_PATH}/${LOCAL_TAG}.tar.gz"
echo ""

