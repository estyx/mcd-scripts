#!/bin/bash

git clone git://github.com/djh/aeon.git "Aeon Stark"
wget -q http://www.stud.hig.no/~070620/Aeon_Fonts260409.zip
cd Aeon\ Stark
rm -rf .git
cd ..
sudo cp -R Aeon\ Stark /usr/share/xbmc/skin/
unzip Aeon_Fonts260409.zip
cd Aeon
sudo cp -R fonts /usr/share/xbmc/skin/Aeon\ Stark/