#!/bin/bash

if [ ! -f myconfig.sh ]; then
    cp config.sh myconfig.sh
fi

source myconfig.sh

cd minigui
./autogen.sh; ./configure --enable-develmode --with-runmode=$RUNMODE $MGOPTS
make clean; make -j$NR_JOBS; sudo make install
cd ..

for comp in minigui-res mg-tests mgutils mgplus mgeff mgncs mgncs4touch mg-tools mg-samples mg-demos cell-phone-ux-demo; do
    cd $comp
    ./autogen.sh; ./configure --enable-develmode
    make clean; make -j$NR_JOBS; sudo make install
    cd ..
done
