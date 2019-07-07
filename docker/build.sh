#!/bin/bash
cd /tmp

git clone --single-branch --branch MrFlutters-patch-1 https://github.com/MrFlutters/lua-cjson.git

LUAROCKS_VER=2.4.2
LUA_DIR=/usr/local
LUA_INCLUDE_DIR=$LUA_DIR/include/luajit-2.1/
LUA_SUFFIX=--lua-suffix=jit

git clone -b v2.1-agentzh https://github.com/openresty/luajit2.git
cd ./luajit2
make -C src
sudo make install
cd ..

sudo ln -s $LUA_DIR/bin/luajit $LUA_DIR/bin/lua
sudo cpanm --notest Test::Base Test::LongString  
wget https://luarocks.github.io/luarocks/releases/luarocks-$LUAROCKS_VER.tar.gz
tar -zxf luarocks-$LUAROCKS_VER.tar.gz
cd luarocks-$LUAROCKS_VER
./configure --with-lua=$LUA_DIR --with-lua-include=$LUA_INCLUDE_DIR $LUA_SUFFIX
make build
sudo make install
cd ../lua-cjson

cppcheck -i ./luajit2 --force --error-exitcode=1 --enable=warning .  
sh runtests.sh
make
prove -Itests tests
TEST_LUA_USE_VALGRIND=1 prove -Itests tests
cp cjson.so /build/