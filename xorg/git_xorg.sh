#! /bin/sh
#
# Copyright (c) 2006 Matthieu Herrb
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
# Some updates by Brian Paul
# XCB update and some cleanup by Peter Hutterer
# Some changes by Espen Killi


gitbase="git://anongit.freedesktop.org/git"

app="appres bdftopcf bitmap constype edid-decode editres fonttosfnt fstobdf iceauth ico luit xfs xfsinfo xgamma xhost xinit xinput xkbcomp xkbevd xkbprint xkbutils xkill xload xlsatoms xlsclients xlsfonts xmodmap xrandr xrdb xrefresh xset xsetpointer xsetroot xshowdamage xsm xstdcmap xvidtune xvinfo xwd xwininfo xwud xdpyinfo"

data="bitmaps cursors"

doc="xorg-docs xorg-sgml-doctools"

driver="xf86-input-evdev xf86-input-keyboard xf86-input-mouse xf86-input-void xf86-video-apm xf86-video-modesetting"

font="adobe-100dpi adobe-75dpi adobe-utopia-100dpi adobe-utopia-75dpi adobe-utopia-type1 alias arabic-misc bh-100dpi bh-75dpi bh-lucidatypewriter-100dpi bh-lucidatypewriter-75dpi bh-ttf bh-type1 bitstream-100dpi bitstream-75dpi bitstream-speedo bitstream-type1 cronyx-cyrillic cursor-misc daewoo-misc dec-misc encodings ibm-type1 isas-misc jis-misc micro-misc misc-cyrillic misc-ethiopic misc-meltho misc-misc mutt-misc schumacher-misc screen-cyrillic sony-misc sun-misc util winitzki-cyrillic xfree86-type1"

lib="libdmx libfontenc libFS libICE liblbxutil libpciaccess libSM libX11 libXau libXaw libXCalibrate libXcomposite libXcursor libXdamage libXdmcp libXevie libXext libXfixes libXfontcache libXfont libXft libXi libXinerama libxkbfile libxkbui libXlg3d libXmu libXpm libXrandr libXrender libXRes libXScrnSaver libXt libxtrans libXTrap libXtst libXv libXvMC libXxf86dga libXxf86misc libXxf86rush libXxf86vm"

proto="applewmproto bigreqsproto calibrateproto compositeproto damageproto dmxproto dri2proto evieproto fixesproto fontcacheproto fontsproto glproto inputproto kbproto lg3dproto pmproto printproto randrproto recordproto renderproto resourceproto scrnsaverproto trapproto videoproto windowswmproto x11proto xcmiscproto xextproto xf86bigfontproto xf86dgaproto xf86driproto xf86miscproto xf86rushproto xf86vidmodeproto xineramaproto xproto"

util="cf gccmakedep imake lndir macros makedepend xmkmf"

xcb="libxcb proto pthread-stubs util"

# $1 is the main project path in the git repository (e.g. xorg).
# $2 is the module's directory (e.g. lib)
# $3 is the module name (e.g. libXi)
# $1 and $2 can be '.', in which case they are ignored.
# The path for git clone will be $gitbase/$1/$2/$3 
do_dir () {
        dir=$2
        if [ ! -d ${dir} ]; then 
                echo "creating ${dir}"
                mkdir -p ${dir}
        fi
        for d in $3; do 
                if [ -d "${dir}/$d" ]; then
                        echo "${dir}/$d exists, pulling"
                        (cd "${dir}/$d" ; git pull)
                else
                        echo "cloning ${dir}/${d}"
            if [ $1 = '.' ] ; then
                src="${gitbase}"
            else
                src="${gitbase}/$1"
            fi

                        if [ ${dir} = '.' ] ; then
                                src="${src}/$d"
                        else
                                src="${src}/${dir}/$d"
                        fi
                        (cd "${dir}" ; git clone ${src})
                fi
        done
}

do_dir xorg app "${app}"
do_dir xorg data "${data}"
do_dir xorg doc "${doc}"
do_dir xorg driver "${driver}"
do_dir xorg font "${font}"
do_dir xorg lib "${lib}"
do_dir xorg proto "${proto}"
do_dir xorg util "${util}"
do_dir . . pixman
do_dir xorg . xserver
do_dir mesa . drm
do_dir . xcb "${xcb}"
do_dir . . pixman
do_dir . . xkeyboard-config