#!/usr/bin/env bash
cp ./Dockerfile-frontend ./Dockerfile
docker buildx build . --output type=docker,name=elestio4test/countly-frontend:latest | docker load