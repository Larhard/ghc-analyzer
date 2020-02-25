FROM haskell:8.4.4
# FROM gregweber/ghc-haskell-dev

RUN apt-get update && apt-get install -y \
    build-essential git autoconf python3 libgmp-dev libncurses-dev alex happy \
    llvm \
    xutils-dev \
    locales \
    sudo \
    vim \
    python3 \
    happy

RUN sed -i -e 's/# en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen

ENV LANG     en_GB.UTF-8
ENV LC_ALL   en_GB.UTF-8
ENV LANGUAGE en_GB.UTF-8

RUN useradd -m -d /home/ghc -s /bin/bash ghc
RUN echo "ghc ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ghc && chmod 0440 /etc/sudoers.d/ghc
ENV HOME /home/ghc

WORKDIR /home/ghc
USER ghc

CMD /bin/bash
