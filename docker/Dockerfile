FROM arm32v7/ubuntu:22.04

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt install \
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
        lua5.1 \
        liblua5.1-0-dev \
        -y \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean