#!/bin/bash

if [ ! -f myconfig.sh ]; then
    cp config.sh myconfig.sh
fi

source myconfig.sh

compile_components() {
    for comp in mgutils mgplus mgeff mgncs mgncs4touch mg-tests mg-tools mg-samples mg-demos cell-phone-ux-demo; do
        cd $comp
        ./configure && make clean && make -j$NR_JOBS && sudo make install
        if [ "$?" != "0" ]; then
            echo "ERROR WHEN COMPILING $comp"
            exit 1
        fi
        cd ..
    done
}

echo "MINIGUI THREADS"
cd minigui
./configure --with-runmode=ths --enable-develmode && make clean && make -j$NR_JOBS && sudo make install
if [ "$?" != "0" ]; then
    echo "ERROR WHEN COMPILING MINIGUI-THREADS"
    exit 1
fi
cd ..

compile_components

echo "MINIGUI STANDALONE"
cd minigui
./configure --with-runmode=sa --enable-develmode && make clean && make -j$NR_JOBS && sudo make install
if [ "$?" != "0" ]; then
    echo "ERROR WHEN COMPILING MINIGUI-STANDALONE"
    exit 1
fi
cd ..

compile_components

echo "MINIGUI PROCESSES WITH SHAREDFB SCHEMA"
cd minigui
./configure --with-runmode=procs --disable-compositing --enable-develmode && make clean && make -j$NR_JOBS && sudo make install
if [ "$?" != "0" ]; then
    echo "ERROR WHEN COMPILING MINIGUI-PROCESSES WITH SHAREDFB SCHEMA"
    exit 1
fi
cd ..

compile_components

echo "MINIGUI PROCESSES WITH COMPOSITING SCHEMA"
cd minigui
./configure --with-runmode=procs --enable-develmode && make clean && make -j$NR_JOBS && sudo make install
if [ "$?" != "0" ]; then
    echo "ERROR WHEN COMPILING MINIGUI-PROCESSES WITH SHAREDFB SCHEMA"
    exit 1
fi
cd ..

compile_components

exit 0
