#!/bin/bash

if [ ! -f myconfig.sh ]; then
    cp config.sh myconfig.sh
fi

source myconfig.sh

for comp in minigui-res mg-samples minigui mgutils mgplus mgeff mgncs mgncs4touch mg-demos cell-phone-ux-demo; do
    echo "checking status in $comp"
    cd $comp
    git status
    cd ..
done
