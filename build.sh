#!/bin/bash

# Variables
IMAGE_NAME="afrid1296/devops-guvi"
TAG="latest"
DEV_REPO="afrid1296/devops-guvi"
PROD_REPO="afrid1296/devops-guvi-prod"

echo "Building the Docker image: $IMAGE_NAME:$TAG"

docker build -t $IMAGE_NAME:$TAG .

if [ $? -eq 0 ]; then
    echo "Docker image $IMAGE_NAME:$TAG built successfully."
else
    echo "Failed to build the Docker image."
    exit 1
fi

echo "Pushing image to dev repository: $DEV_REPO"
docker push $DEV_REPO:$TAG

if [ $? -eq 0 ]; then
    echo "Image pushed to dev repository successfully."
else
    echo "Failed to push to dev repository."
    exit 1
fi
