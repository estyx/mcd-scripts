#!/bin/bash

section=doc
cd $section

packages="xorg-docs xorg-sgml-doctools"

# build packages
for package in $packages
do
  cd $package
  sh autogen.sh $XORG_CONFIG
  make
  sudo make install
  cd ..
done 2>&1 | tee -a compile-${section}.log #log the entire loop
