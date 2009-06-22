#!/bin/bash

XORG_CONFIG="--prefix=/usr --sysconfdir=/etc --mandir=$XORG_PREFIX/share/man --localstatedir=/var"

cd xserver

if [ "$1" = "clean" ]; then
  make clean
  if [ -f .done ]; then
    rm .done
  fi
  echo "xserver cleaned up!"
elif [ "$1" = "uninstall" ]; then
  sudo make uninstall
  echo "xserver uninstalled!"
elif [ "$1" = "install" ]; then
  sudo make install
else
  if [ -f .done ]; then
    echo "xserver already built, skipping!"
  else
    echo ""
    echo "------| BUILDING: xserver |-------"
    echo ""
    sh autogen.sh $XORG_CONFIG --with-module-dir=$XORG_PREFIX/lib/X11/modules --with-xkb-output=/var/lib/xkb --enable-install-setuid
    make
    sudo make install
    touch .done
  fi
fi

cd ..

echo ""
echo "DONE!"
echo ""
