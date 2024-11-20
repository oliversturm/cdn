#!/bin/bash

docker buildx build --pull --no-cache --platform linux/amd64,linux/arm64 -t oliversturm/cdn:8 .
