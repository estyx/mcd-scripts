#!/bin/bash

XORG_CONFIG="--prefix=/usr --sysconfdir=/etc --mandir=$XORG_PREFIX/share/man --localstatedir=/var"

cd lib/libXau

if [ "$1" = "clean" ]; then
  make clean
  if [ -f .done ]; then
    rm .done
  fi
  echo "libXau cleaned up!"
elif [ "$1" = "uninstall" ]; then
  sudo make uninstall
  echo "libXau uninstalled!"
elif [ "$1" = "install" ]; then
  sudo make install
else
  if [ -f .done ]; then
    echo "libXau already built, skipping!"
  else
    echo ""
    echo "------| BUILDING: libXau |-------"
    echo ""
    sh autogen.sh $XORG_CONFIG
    make
    sudo make install
    touch .done
  fi
fi

cd ..

echo ""
echo "DONE!"
echo ""
