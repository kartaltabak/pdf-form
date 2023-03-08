#!/bin/zsh

NAME=ups
REMOTE_PATH=576384128468.dkr.ecr.us-east-1.amazonaws.com/dev/search-pg

aws-ecr-login.sh &&
  docker build \
    -t ${NAME} \
    -t ${REMOTE_PATH}/${NAME} \
    docker
