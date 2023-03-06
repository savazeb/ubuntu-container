#!/usr/bin/env bash

TAG="${TAG:-latest}"

# check whether image exist or not
# if not docker will start build the Dockerfile
if [[ "$(docker images -q ubuntu:${TAG} 2> /dev/null)" == "" ]]; then
  docker build --build-arg TAG=${TAG} -t ubuntu .
fi

# cleanup the container
if [[ "$(docker ps -a | grep ubuntu)" ]]; then
  echo "stop working container named ubuntu..."
  docker stop ubuntu
  docker rm ubuntu
fi

# run the container
echo "run container in background..."
docker run -it -d --name ubuntu -v ${PWD}/ubuntu:/ubuntu ubuntu

# open the container shell
echo "starting..."
docker exec -it ubuntu bash

