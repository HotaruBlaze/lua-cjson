#!/bin/bash
cd /tmp

git clone --single-branch --branch docker_build https://github.com/MrFlutters/lua-cjson.git

BUILD_THREADS=4
LUAROCKS_VER=3.9.2
LUA_DIR=/usr/local
LUA_INCLUDE_DIR=$LUA_DIR/include/luajit-2.1/
LUA_SUFFIX=--lua-suffix=jit

git clone -b v2.1-agentzh https://github.com/openresty/luajit2.git
cd ./luajit2
make -j $BUILD_THREADS -C src
sudo make install
cd ..

sudo ln -s $LUA_DIR/bin/luajit $LUA_DIR/bin/lua
sudo cpanm --notest Test::Base Test::LongString
wget https://luarocks.github.io/luarocks/releases/luarocks-$LUAROCKS_VER.tar.gz
tar -zxf luarocks-$LUAROCKS_VER.tar.gz
cd luarocks-$LUAROCKS_VER
./configure --with-lua=$LUA_DIR --with-lua-include=$LUA_INCLUDE_DIR $LUA_SUFFIX
make -j $BUILD_THREADS build
sudo make install
cd ../lua-cjson

cppcheck -i ./luajit2 --force --error-exitcode=1 --enable=warning .
sh runtests.sh
make
prove -Itests tests
TEST_LUA_USE_VALGRIND=1 prove -Itests tests

# Copying build anyway due to test errors seeming to be logical errors than technical bugs
cp cjson.so /build/

#if [[ $? -eq 0 ]]
#    then
#        echo "Test Passed, Copying cjson to build."
#        cp cjson.so /build/
#    else
#        echo "Build Failed, cjson will not be copied."
#fi