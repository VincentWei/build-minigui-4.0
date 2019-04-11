#!/bin/bash

runmode=ths
nr_jobs=16

cd minigui
./autogen.sh; ./configure --enable-develmode --with-runmode=$runmode
make -j$nr_jobs; sudo make install
cd ..

for comp in minigui-res mg-tests mgutils mgplus mgeff mgncs mgncs4touch mg-samples cell-phone-ux-demo; do
    cd $comp
    ./autogen.sh; ./configure --enable-develmode
    make -j$nr_jobs; sudo make install
    cd ..
done
