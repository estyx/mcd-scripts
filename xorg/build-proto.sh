#!/bin/bash

XORG_CONFIG="--prefix=/usr --sysconfdir=/etc --mandir=$XORG_PREFIX/share/man --localstatedir=/var"

section=proto
cd $section

packages="applewmproto bigreqsproto calibrateproto compositeproto damageproto dmxproto dri2proto evieproto fixesproto fontcacheproto fontsproto glproto inputproto kbproto lg3dproto pmproto printproto randrproto recordproto renderproto resourceproto scrnsaverproto trapproto videoproto windowswmproto x11proto xcmiscproto xextproto xf86bigfontproto xf86dgaproto xf86driproto xf86miscproto xf86rushproto xf86vidmodeproto xineramaproto xproto"

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
      sudo make install
      touch .done
    fi
  fi
  cd ..
done 2>&1 | tee -a compile-${section}.log #log the entire loop

echo ""
echo "DONE!"
echo ""

