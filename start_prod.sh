LOCAL_HOME="$PWD/home"

IMAGE=ghc_analyzer
# DOCKER_HOME=/root/project
DOCKER_HOME=/home/ghc/project

docker run --rm -it --name ghc_analyzer -v "$LOCAL_HOME:$DOCKER_HOME:rw" "$IMAGE" /bin/bash
