FROM debian:unstable-slim

RUN apt update \
    && apt install \
        sudo \
        git \
        rename \
        gcc \
        cmake \
        make \
        wget \
        unzip \
        clang \
        cppcheck \
        valgrind \
        cpanminus \
        libipc-run3-perl \
        lua5.1.0 \
        lua5.1.0-dev \
        -y \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean
