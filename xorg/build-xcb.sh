#!/bin/bash

XORG_CONFIG="--prefix=/usr --sysconfdir=/etc --mandir=$XORG_PREFIX/share/man --localstatedir=/var"

section=xcb
cd $section

packages="pthread-stubs proto libxcb util"

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

