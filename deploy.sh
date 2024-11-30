#!/bin/bash

CONTAINER_NAME="devops-container"
IMAGE_NAME="afrid1296/devops-guvi:latest"

echo "Stopping and removing any existing container: $CONTAINER_NAME"
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

echo "Deploying the container: $CONTAINER_NAME"
docker run -d --name $CONTAINER_NAME -p 80:80 $IMAGE_NAME
