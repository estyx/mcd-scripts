#!/bin/bash

XORG_CONFIG="--prefix=/usr --sysconfdir=/etc --mandir=$XORG_PREFIX/share/man --localstatedir=/var"

cd xkeyboard-config

if [ "$1" = "clean" ]; then
  make clean
  if [ -f .done ]; then
    rm .done
  fi
  echo "xkeyboard-config cleaned up!"
elif [ "$1" = "uninstall" ]; then
  sudo make uninstall
  echo "xkeyboard-config uninstalled!"
elif [ "$1" = "install" ]; then
  sudo make install
else
  if [ -f .done ]; then
    echo "xkeyboard-config already built, skipping!"
  else
    echo ""
    echo "------| BUILDING: xkeyboard-config |-------"
    echo ""
    sh autogen.sh $XORG_CONFIG --with-xkb-rules-symlink=xorg
    make
    sudo make install
    sudo install -dv -m755 /usr/share/doc/xkeyboard-config-1.4
    sudo install -v -m644 docs/{README,HOWTO}* /usr/share/doc/xkeyboard-config-1.4
    touch .done
  fi
fi

cd ..

echo ""
echo "DONE!"
echo ""
