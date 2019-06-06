#!/bin/bash

if [ ! -f myconfig.sh ]; then
    cp config.sh myconfig.sh
fi

source myconfig.sh

nr_jobs=$NR_JOBS

echo "BUILDING gvfb"
cd gvfb
cmake .
make -j$nr_jobs; sudo make install
cd ..

echo "BUILDING chipmunk"
cd 3rd-party/chipmunk
cmake .
make -j$nr_jobs; sudo make install
cd ../..

echo "BUILDING harfbuzz"
cd 3rd-party/harfbuzz
./autogen.sh
./config-extern.sh
make -j$nr_jobs; sudo make install
cd ../..
