#!/bin/bash

echo MAKE TARBALLS OF MINIGUI DOCS
for comp in minigui mgutils mgplus mgeff mgncs; do
    cd $comp
    make docs
    for name in doc-*; do
        tar czf $name.tar.gz $name
        rm $name -rf
    done
    mv *.tar.gz ..
    cd ..
done

echo MAKE TARBALLS OF GVFB
cd gvfb
make package_source
mv *.tar.gz ..
cd ..

echo MAKE TARBALLS OF MINIGUI
for comp in minigui minigui-res mgutils mgplus mgeff mgncs mg-tests mg-samples mgncs4touch cell-phone-ux-demo; do
    cd $comp
    make dist
    mv *.tar.gz ..
    cd ..
done

