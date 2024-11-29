#!/bin/bash

# Variables
IMAGE_NAME="devops-guvi"
TAG="latest"

echo "Building the Docker image: $IMAGE_NAME:$TAG"

# Build the Docker image
docker build -t $IMAGE_NAME:$TAG .

if [ $? -eq 0 ]; then
    echo "Docker image $IMAGE_NAME:$TAG built successfully."
else
    echo "Failed to build the Docker image."
    exit 1
fi

