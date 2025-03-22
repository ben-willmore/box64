#!/bin/bash

#git clone https://github.com/ptitSeb/box64.git
#cd box64

git checkout mirror
mkdir build-nightly && cd build-nightly
CC=gcc-10 CXX=g++-10 cmake .. \
   -DARM64=1 -DARM_DYNAREC=ON -DBOX32=ON -DBOX32_BINFMT=ON
make -j8
make install

mkdir products
cp -r /usr/local/bin/box64* ./products/
cp -r /usr/lib/box64-x86_64-linux-gnu ./products/

mkdir -p ./products/etc/binfmt.d
cp /etc/binfmt.d/box64.conf ./products/etc/binfmt.d/
cp /etc/box64.box64rc ./products/etc/

mkdir final
mv products final/box64
cd final
zip -r box64.zip box64
