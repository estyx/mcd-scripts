#!/bin/sh

packages="
http://no.archive.ubuntu.com/ubuntu/pool/multiverse/f/faac/libfaac0_1.26-0.1ubuntu2_i386.deb
http://no.archive.ubuntu.com/ubuntu/pool/universe/e/enca/libenca0_1.9-6_i386.deb
http://no.archive.ubuntu.com/ubuntu/pool/main/libo/libogg/libogg0_1.1.3-4build1_i386.deb
http://no.archive.ubuntu.com/ubuntu/pool/main/libv/libvorbis/libvorbis0a_1.2.0.dfsg-3.1_i386.deb
http://no.archive.ubuntu.com/ubuntu/pool/main/libv/libvorbis/libvorbisfile3_1.2.0.dfsg-3.1_i386.deb
http://no.archive.ubuntu.com/ubuntu/pool/main/s/smpeg/libsmpeg0_0.4.5+cvs20030824-2.2_i386.deb
http://no.archive.ubuntu.com/ubuntu/pool/main/libm/libmikmod/libmikmod2_3.1.11-a-6ubuntu3_i386.deb
http://no.archive.ubuntu.com/ubuntu/pool/main/s/sdl-mixer1.2/libsdl-mixer1.2_1.2.8-5_i386.deb
http://no.archive.ubuntu.com/ubuntu/pool/main/s/sdl-image1.2/libsdl-image1.2_1.2.6-3_i386.deb
http://no.archive.ubuntu.com/ubuntu/pool/main/libc/libcdio/libcdio7_0.78.2+dfsg1-3_i386.deb
http://no.archive.ubuntu.com/ubuntu/pool/main/l/lzo2/liblzo2-2_2.03-1_i386.deb
http://no.archive.ubuntu.com/ubuntu/pool/main/p/pcre3/libpcre3_7.8-2ubuntu1_i386.deb
http://no.archive.ubuntu.com/ubuntu/pool/main/m/mysql-dfsg-5.0/mysql-common_5.1.30really5.0.75-0ubuntu10_all.deb
http://no.archive.ubuntu.com/ubuntu/pool/main/m/mysql-dfsg-5.0/libmysqlclient15off_5.1.30really5.0.75-0ubuntu10_i386.deb
http://no.archive.ubuntu.com/ubuntu/pool/main/f/fribidi/libfribidi0_0.10.9-1_i386.deb
http://no.archive.ubuntu.com/ubuntu/pool/main/b/bzip2/libbz2-1.0_1.0.5-1ubuntu1_i386.deb
http://no.archive.ubuntu.com/ubuntu/pool/main/libm/libmad/libmad0_0.15.1b-4_i386.deb
http://no.archive.ubuntu.com/ubuntu/pool/main/g/glew/libglew1.5_1.5.0dfsg1-3ubuntu1_i386.deb
http://no.archive.ubuntu.com/ubuntu/pool/main/t/tiff/libtiff4_3.8.2-11_i386.deb
https://launchpad.net/~team-xbmc/+archive/intrepid-ppa/+files/xbmc-common_9.04.1-intrepid1_i386.deb
https://launchpad.net/~team-xbmc/+archive/intrepid-ppa/+files/xbmc-eventclients-common_9.04.1-intrepid1_i386.deb
https://launchpad.net/~team-xbmc/+archive/intrepid-ppa/+files/xbmc-skin-pm3-hd_9.04.1-intrepid1_i386.deb
https://launchpad.net/~team-xbmc/+archive/intrepid-ppa/+files/xbmc-skin-pm3_9.04.1-intrepid1_i386.deb
https://launchpad.net/~team-xbmc/+archive/intrepid-ppa/+files/xbmc-web-pm3_9.04.1-intrepid1_i386.deb
https://launchpad.net/~team-xbmc/+archive/intrepid-ppa/+files/xbmc-web-pm_9.04.1-intrepid1_i386.deb
https://launchpad.net/~team-xbmc/+archive/intrepid-ppa/+files/xbmc_9.04.1-intrepid1_i386.deb
"

echo "Installing packages.. "
echo ""

# download and install packages
for package in $packages
do
  file=`basename $package`
  echo "Downloading and installing $file"
  wget -q $package --no-check-certificate
  ar p $file data.tar.gz | tar pzx -C /
done 2>&1 | tee -a install-xbmc.log #log the entire loop

echo "Done!"
