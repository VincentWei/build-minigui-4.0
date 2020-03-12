#!/bin/bash

if [ ! -f myconfig.sh ]; then
    cp config.sh myconfig.sh
fi

source myconfig.sh

# GVFB, always in master
git clone $REPO_URL/gvfb.git

# The third-party libraries, alawys in master
for comp in harfbuzz chipmunk; do
    cd 3rd-party; git clone $REPO_URL/$comp.git; cd ..
done

# MiniGUI, MiniGUI components and samples, demos
for comp in minigui-res minigui mg-tests mgutils mgplus mgeff mgncs mgncs4touch mg-samples mg-demos; do
    git clone $REPO_URL/$comp.git -b $BRANCH_NAME
done

# Tools and demos are always in master
for comp in mg-tools cell-phone-ux-demo; do
    git clone $REPO_URL/$comp.git
done

