#!/bin/bash

if [ ! -f myconfig.sh ]; then
    cp config.sh myconfig.sh
fi

source myconfig.sh

RUNMODE="CURRENT RUNTIME INSTALLED"

check_minigui_components() {
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

check_minigui_ths() {
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

    check_components
}

check_minigui_sa() {
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

    check_components
}

check_minigui_procs_sharedfb() {
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

    check_components
}

check_minigui_procs_compos() {
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

    check_components
}

if [ $# == 0 ]; then
    check_minigui_ths
    check_minigui_sa
    check_minigui_procs_sharedfb
    check_minigui_procs_compos
else
    for i in $*
    do
        check_minigui_$i
    done
fi

echo "====="
echo "PASSED"
echo "====="

exit 0
