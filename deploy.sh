#!/bin/bash

ROOTPATH=$(dirname $(readlink -e "${BASH_SOURCE[0]}"))

# Remove the credentials so that they are auto generated at startup,
# with information contained in yaml file

sudo rm -rf db/users

docker compose build --build-arg=GIT_COMMIT=$(git rev-parse --short HEAD)
docker compose up --detach