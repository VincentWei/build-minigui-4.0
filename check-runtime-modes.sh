#!/bin/bash

if [ ! -f myconfig.sh ]; then
    cp config.sh myconfig.sh
fi

source myconfig.sh

RUNMODE="CURRENT RUNTIME INSTALLED"

check_minigui_components() {
    for comp in mgutils mgplus mgeff mgncs mgncs4touch mg-tests mg-tools mg-samples mg-demos cell-phone-ux-demo; do
        cd $comp
        ./configure --disable-static && make clean && make -j$NR_JOBS && sudo make install
        if [ "$?" != "0" ]; then
            echo "====="
            echo "ERROR WHEN COMPILING $comp FOR $RUNMODE"
            echo "====="
            exit 1
        fi
        cd ..
    done
}

check_minigui_test() {
    for comp in mgutils mg-tests; do
        cd $comp
        ./configure --disable-static && make clean && make -j$NR_JOBS && sudo make install
        if [ "$?" != "0" ]; then
            echo "====="
            echo "ERROR WHEN COMPILING $comp FOR $RUNMODE"
            echo "====="
            exit 1
        fi
        cd ..
    done
}

check_minigui_ths() {
    RUNMODE="MINIGUI THREADS"
    cd minigui
    ./configure --disable-static --with-runmode=ths --enable-develmode && make clean && make -j$NR_JOBS && sudo make install
    if [ "$?" != "0" ]; then
        echo "====="
        echo "ERROR WHEN COMPILING minigui FOR $RUNMODE"
        echo "====="
        exit 1
    fi
    cd ..

    check_minigui_components
}

check_minigui_ths_incore() {
    RUNMODE="MINIGUI THREADS WITH INCORE RESOURCE"
    cd minigui
    ./configure --disable-static --with-runmode=ths --enable-incoreres --enable-develmode && make clean && make -j$NR_JOBS && sudo make install
    if [ "$?" != "0" ]; then
        echo "====="
        echo "ERROR WHEN COMPILING minigui FOR $RUNMODE"
        echo "====="
        exit 1
    fi
    cd ..

    check_minigui_components
}

check_minigui_ths_nocursor() {
    RUNMODE="MINIGUI THREADS WITH NO CURSOR"
    cd minigui
    ./configure --disable-static --with-runmode=ths --disable-cursor --enable-develmode && make clean && make -j$NR_JOBS && sudo make install
    if [ "$?" != "0" ]; then
        echo "====="
        echo "ERROR WHEN COMPILING minigui FOR $RUNMODE"
        echo "====="
        exit 1
    fi
    cd ..

    check_minigui_components
}

check_minigui_sa() {
    RUNMODE="MINIGUI STANDALONE"
    cd minigui
    ./configure --disable-static --with-runmode=sa --enable-develmode && make clean && make -j$NR_JOBS && sudo make install
    if [ "$?" != "0" ]; then
        echo "====="
        echo "ERROR WHEN COMPILING minigui FOR $RUNMODE"
        echo "====="
        exit 1
    fi
    cd ..

    check_minigui_components
}

check_minigui_procs_sharedfb() {
    RUNMODE="MINIGUI PROCESSES WITH SHAREDFB SCHEMA"
    cd minigui
    ./configure --disable-static --with-runmode=procs --disable-compositing --enable-develmode && make clean && make -j$NR_JOBS && sudo make install
    if [ "$?" != "0" ]; then
        echo "====="
        echo "ERROR WHEN COMPILING minigui FOR $RUNMODE"
        echo "====="
        exit 1
    fi
    cd ..

    check_minigui_components
}

check_minigui_procs_compos() {
    RUNMODE="MINIGUI PROCESSES WITH COMPOSITING SCHEMA"
    cd minigui
    ./configure --disable-static --with-runmode=procs --enable-compositing --enable-develmode && make clean && make -j$NR_JOBS && sudo make install
    if [ "$?" != "0" ]; then
        echo "====="
        echo "ERROR WHEN COMPILING minigui FOR $RUNMODE"
        echo "====="
        exit 1
    fi
    cd ..
}

check_minigui_with_options() {
    RUNMODE="MiniGUI configured with $1"
    cd minigui
    ./configure --disable-static --enable-develmode $1 && make clean && make -j$NR_JOBS && sudo make install
    if [ "$?" != "0" ]; then
        echo "====="
        echo "ERROR WHEN COMPILING minigui FOR $RUNMODE"
        echo "====="
        exit 1
    fi
    cd ..

    if [ "x$ONLYTEST" = "xyes" ]; then
        check_minigui_test
    else
        check_minigui_components
    fi
}

check_with_options() {
    OPTIONS="--with-runmode=$1"

    index=1
    for i in $*
    do
        if [ $index != 1 ]; then
            if [ ${i:0:1} = "-" ]; then
                OPTIONS="$OPTIONS --disable$i"
            else
                OPTIONS="$OPTIONS --enable-$i"
            fi
        fi
        let index+=1
    done

    check_minigui_with_options "$OPTIONS"
}

if [ $# == 0 ]; then
    ONLYTEST="no"

    check_with_options ths
    check_with_options ths -cursor
    check_with_options ths incoreres
    check_with_options ths incoreres -cursor

    check_with_options sa
    check_with_options sa -cursor
    check_with_options sa incoreres
    check_with_options sa incoreres -cursor

    check_with_options procs -compositing
    check_with_options procs -compositing -cursor
    check_with_options procs -compositing incoreres
    check_with_options procs -compositing incoreres -cursor

    check_with_options procs compositing -cursor
    check_with_options procs compositing incoreres
    check_with_options procs compositing incoreres -cursor
    check_with_options procs compositing -syncupdate
    check_with_options procs compositing syncupdate
else
    ONLYTEST="no"

    check_with_options $*
fi

echo "====="
echo "PASSED"
echo "====="

exit 0
