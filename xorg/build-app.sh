#!/bin/bash

XORG_CONFIG="--prefix=/usr --sysconfdir=/etc --mandir=$XORG_PREFIX/share/man --localstatedir=/var"

section=app
cd $section

packages="appres bdftopcf bitmap constype editres fonttosfnt fstobdf iceauth ico luit xfs xfsinfo xgamma xhost xinit xinput xkbcomp xkbevd xkbprint xkbutils xkill xload xlsatoms xlsclients xlsfonts xmodmap xrandr xrdb xrefresh xset xsetpointer xsetroot xsm xstdcmap xvidtune xvinfo xwd xwininfo xwud xdpyinfo"

# build packages
for package in $packages
do
  cd $package
  if [ "$1" = "clean" ]; then
    make clean
    if [ -f .done ]; then
      rm .done
    fi
    echo "$package (${section}) cleaned up!"
  elif [ "$1" = "uninstall" ]; then
    sudo make uninstall
    echo "$package (${section}) uninstalled!"
  elif [ "$1" = "install" ]; then
    sudo make install
  else
    if [ -f .done ]; then
      echo "$package (${section}) already built, skipping!"
    else
      echo ""
      echo "------| BUILDING: $package (${section}) |-------"
      echo ""
      sh autogen.sh $XORG_CONFIG
      make
      sudo make install
      touch .done
    fi
  fi
  cd ..
done 2>&1 | tee -a compile-${section}.log #log the entire loop

echo ""
echo "DONE!"
echo ""
