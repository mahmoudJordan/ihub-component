#!/bin/bash

# Ensure that IMAGE_NAME and IMAGE_NAME_LOCAL are either passed as environment variables or set them here
if [ -z "${IMAGE_NAME}" ]; then
    echo "IMAGE_NAME is not set. Exiting..."
    exit 1
fi

if [ -z "${IMAGE_NAME_LOCAL}" ]; then
    echo "IMAGE_NAME_LOCAL is not set. Exiting..."
    exit 1
fi

# Check if the first parameter is passed and is true
USE_LOCAL_IMAGE=${1:-false}

# Going back to dockerfile directory
cd ../

echo "Current folder to build image in is $(pwd)"

if [ "$USE_LOCAL_IMAGE" = true ]; then
    echo "Using local image name: ${IMAGE_NAME_LOCAL}"
    docker build --progress=plain -t ${IMAGE_NAME_LOCAL} .
    docker push ${IMAGE_NAME_LOCAL}
else
    echo "Using image name: ${IMAGE_NAME}"
    docker build --progress=plain -t ${IMAGE_NAME} .
    docker push ${IMAGE_NAME}
fi

# Uncomment the next line if you need to push to a specific repository
# docker push mahmoudalsarhan/oih-bconnect-component
