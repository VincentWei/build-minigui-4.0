#!/bin/bash

# GVFB
git clone git@github.com:VincentWei/gvfb.git

# The third-party libraries
for comp in harfbuzz chipmunk; do
    cd 3rd-party; git clone git@github.com:VincentWei/$comp.git; cd ..
done

# MiniGUI, MiniGUI components and samples, demos
for comp in minigui-res minigui mg-tests mg-tools mgutils mgplus mgeff mgncs mgncs4touch mg-samples cell-phone-ux-demo; do
    git clone git@github.com:VincentWei/$comp.git
done

