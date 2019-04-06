#!/bin/bash

# GVFB
echo Updating gvfb
cd gvfb; git pull; cd ..

# The third-party libraries
for comp in harfbuzz chipmunk; do
    echo Updating $comp
    cd 3rd-party/$comp; git pull; cd ../..
done

# MiniGUI core, components, tools, samples, and demos
for comp in minigui-res minigui mg-tests mgutils mgplus mgeff mgncs mgncs4touch mg-samples mg-tools cell-phone-ux-demo; do
    echo Updating $comp
    cd $comp
    git pull
    cd ..
done
