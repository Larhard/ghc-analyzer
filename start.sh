LOCAL_HOME="$PWD/home"
docker run --rm -it --name ghc_analyzer -v "$LOCAL_HOME:/root:rw" ghc_analyzer
