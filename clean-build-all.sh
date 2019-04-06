#!/bin/bash

runmode=ths

echo UNINSTALL, MAKE, AND INSTALL MiniGUI FIRST...
cd minigui
./autogen.sh; ./configure --enable-develmode --with-runmode=$runmode
sudo make uninstall; make clean; make; sudo make install
cd ..

echo UNINSTALL AND CLEAN OTHERS...
for comp in mgncs4touch mgncs mgeff mgplus mgutils; do
    cd $comp
    ./autogen.sh; ./configure --enable-develmode
    sudo make uninstall; make clean
    cd ..
done

echo MAKE AND INSTALL NOW...
for comp in mg-tests mgutils mgplus mgeff mgncs mgncs4touch mg-samples mg-tools cell-phone-ux-demo; do
    cd $comp
    make; sudo make install
    cd ..
done
