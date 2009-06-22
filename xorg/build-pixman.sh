#!/bin/bash

cd pixman
sh autogen.sh
make
sudo make install
cd ..
