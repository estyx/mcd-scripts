#!/bin/bash

XORG_CONFIG="--prefix=/usr --sysconfdir=/etc --mandir=$XORG_PREFIX/share/man --localstatedir=/var"

section=font
cd $section

packages="util adobe-100dpi adobe-75dpi adobe-utopia-100dpi adobe-utopia-75dpi adobe-utopia-type1 alias arabic-misc bh-100dpi bh-75dpi bh-lucidatypewriter-100dpi bh-lucidatypewriter-75dpi bh-ttf bh-type1 bitstream-100dpi bitstream-75dpi bitstream-speedo bitstream-type1 cronyx-cyrillic cursor-misc daewoo-misc dec-misc encodings ibm-type1 isas-misc jis-misc micro-misc misc-cyrillic misc-ethiopic misc-meltho misc-misc mutt-misc schumacher-misc screen-cyrillic sony-misc sun-misc winitzki-cyrillic xfree86-type1"

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
      echo
      echo "------| BUILDING: $package (${section}) |-------"
      echo
      sh autogen.sh $XORG_CONFIG
      make
      sudo make install
      touch .done
    fi
  fi
  cd ..
done 2>&1 | tee -a compile-${section}.log #log the entire loop

echo "Making Fontconfig able to find the TrueType fonts (symlinking)"
sudo install -v -d -m755 /usr/share/fonts
sudo ln -svn $XORG_PREFIX/lib/X11/fonts/OTF /usr/share/fonts/X11-OTF
sudo ln -svn $XORG_PREFIX/lib/X11/fonts/TTF /usr/share/fonts/X11-TTF

echo
echo "DONE!"
echo

