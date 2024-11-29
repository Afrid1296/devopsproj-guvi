#!/bin/bash

# Variables
IMAGE_NAME="devops-guvi"
TAG="latest"
CONTAINER_NAME="devops-container"
PORT="3000"

echo "Stopping and removing any existing container: $CONTAINER_NAME"
docker stop $CONTAINER_NAME 2>/dev/null && docker rm $CONTAINER_NAME 2>/dev/null

echo "Deploying the container: $CONTAINER_NAME"
docker run -d -p $PORT:80 --name $CONTAINER_NAME $IMAGE_NAME:$TAG

if [ $? -eq 0 ]; then
    echo "Container $CONTAINER_NAME deployed successfully and is running on port $PORT."
else
    echo "Failed to deploy the container."
    exit 1
fi

