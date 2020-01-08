$LOCAL_HOME = "$PWD\home" -replace "\\","/"
docker run --rm -it --name ghc_analyzer -v "$LOCAL_HOME`:/root:rw" ghc_analyzer
