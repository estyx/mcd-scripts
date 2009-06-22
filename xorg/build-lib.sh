#!/bin/bash

XORG_CONFIG="--prefix=/usr --sysconfdir=/etc --mandir=$XORG_PREFIX/share/man --localstatedir=/var"
PATH=$PATH:/sbin:/usr/sbin

section=lib
cd $section

packages="libfontenc libxtrans libFS libICE liblbxutil libpciaccess libSM libX11 libXext libdmx libXt libXmu libXfixes libXCalibrate libXcomposite libXrender libXcursor libXdamage libXevie libXfixes libXfontcache libXfont libXft libXi libXinerama libXaw libxkbfile libxkbui libXlg3d libXpm libXrandr libXRes libXScrnSaver libXTrap libXtst libXv libXvMC libXxf86dga libXxf86misc libXxf86vm"

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
      sudo ldconfig
      touch .done
    fi
  fi
  cd ..
done 2>&1 | tee -a compile-${section}.log #log the entire loop

echo ""
echo "DONE!"
echo ""

