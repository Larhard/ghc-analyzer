FROM haskell:8.8.1

RUN apt-get update && apt-get install -y \
    vim

RUN cabal update && cabal install --lib \
    ghc-paths

WORKDIR /root
CMD /bin/bash
