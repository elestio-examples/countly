#!/usr/bin/env bash
rm -f ./Dockerfile
cp ./Dockerfile-frontend ./Dockerfile
docker buildx build . --output type=docker,name=elestio4test/countly-frontend:latest | docker load