#!/bin/bash

if [ ! -f myconfig.sh ]; then
    cp config.sh myconfig.sh
fi

source myconfig.sh

RUNMODE=

compile_components() {
    for comp in mgutils mgplus mgeff mgncs mgncs4touch mg-tests mg-tools mg-samples mg-demos cell-phone-ux-demo; do
        cd $comp
        ./configure && make clean && make -j$NR_JOBS && sudo make install
        if [ "$?" != "0" ]; then
            echo "====="
            echo "ERROR WHEN COMPILING $comp FOR $RUMMODE"
            echo "====="
            exit 1
        fi
        cd ..
    done
}

RUNMODE="MINIGUI THREADS"
cd minigui
./configure --with-runmode=ths --enable-develmode && make clean && make -j$NR_JOBS && sudo make install
if [ "$?" != "0" ]; then
    echo "====="
    echo "ERROR WHEN COMPILING minigui FOR $RUNMODE"
    echo "====="
    exit 1
fi
cd ..

compile_components

RUNMODE="MINIGUI STANDALONE"
cd minigui
./configure --with-runmode=sa --enable-develmode && make clean && make -j$NR_JOBS && sudo make install
if [ "$?" != "0" ]; then
    echo "====="
    echo "ERROR WHEN COMPILING minigui FOR $RUNMODE"
    echo "====="
    exit 1
fi
cd ..

compile_components

RUNMODE="MINIGUI PROCESSES WITH SHAREDFB SCHEMA"
cd minigui
./configure --with-runmode=procs --disable-compositing --enable-develmode && make clean && make -j$NR_JOBS && sudo make install
if [ "$?" != "0" ]; then
    echo "====="
    echo "ERROR WHEN COMPILING minigui FOR $RUNMODE"
    echo "====="
    exit 1
fi
cd ..

compile_components

RUNMODE="MINIGUI PROCESSES WITH COMPOSITING SCHEMA"
cd minigui
./configure --with-runmode=procs --enable-compositing --enable-develmode && make clean && make -j$NR_JOBS && sudo make install
if [ "$?" != "0" ]; then
    echo "====="
    echo "ERROR WHEN COMPILING minigui FOR $RUNMODE"
    echo "====="
    exit 1
fi
cd ..

compile_components

echo "====="
echo "PASSED"
echo "====="

exit 0
