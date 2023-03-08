#!/bin/zsh

"${0:A:h}/build.sh" &&
  aws-ecr-push-image.sh ups 1.0

