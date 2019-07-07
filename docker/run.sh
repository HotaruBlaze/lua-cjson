#!/bin/bash
docker build -t mrflutters/cjson-builder .

rm -rf build/

docker run --rm -ti \
    -v $PWD/build/:/build \
    -v $PWD/build.sh:/build.sh \
    mrflutters/cjson-builder bash /build.sh

sudo chown -R $UID:$UID build/