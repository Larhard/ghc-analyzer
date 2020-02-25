LOCAL_HOME="$PWD/home"

IMAGE=gregweber/ghc-haskell-dev
DOCKER_HOME=/home/ghc/project

docker run --rm -it --name ghc_analyzer -v "$LOCAL_HOME:$DOCKER_HOME:rw" "$IMAGE" /bin/bash
