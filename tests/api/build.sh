#!/usr/bin/env bash
rm -f ./Dockerfile
cp ./Dockerfile-api ./Dockerfile
docker buildx build . --output type=docker,name=elestio4test/countly-api:latest | docker load