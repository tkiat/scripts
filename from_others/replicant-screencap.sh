#!/bin/sh
# ./screencap.sh -f output.png
# ./screencap.sh -s 720x1280 -f output.png
# Copyright (C) 2017 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

set -e

FFMEG="ffmpeg"
ADB_PATH="adb"
FB_PATH="/dev/graphics/fb0"
SSH_HOST=""

TMP_FB="fb_raw"
TMP_FB_RS="fb_raw_rs"
RECOVERY=false

ssh_wrapper()
{
        if [ "$1" = "shell" ] ; then
		shift 1
                ssh "${SSH_HOST}" "su -c \"$@\""
        elif [ "$1" = "pull" ] ; then
		shift 1
                scp ${SSH_HOST}:$@
        fi
}

print_usage () {
    echo
    echo "Usage: $0 [OPTIONS] -f OUTPUT.PNG"
    echo "       $0 [OPTIONS] --filename OUTPUT.PNG"
    echo
    echo "Options:"
    echo "-r, --recovery        Device is booted in recovery mode"
    echo "-s, --screen-size     Specify screen size (mandatory in recovery mode)"
    echo "-h, --ssh-host        Connect to the given host through SSH"
    echo
}

print_recovery_advice () {
    echo "For screenshots in recovery mode, the screen size needs to be specified,"
    echo "e.g. with \"-s 720x1280\""
}

get_screen_size () {
    if [ -f $( $ADB shell command -v wm ) ]; then
	echo "Screen size can't be determined. Are you in recovery mode?"
	print_recovery_advice
	exit 1
    fi

    SCREEN_SIZE=$( $ADB shell wm size )
    SCREEN_SIZE=$( echo ${SCREEN_SIZE#*: } | tr -d '\r' )

    echo "Screen size is $SCREEN_SIZE"
}

take_screenshot () {
    SCREEN_SIZE_X=${SCREEN_SIZE%x*}
    SCREEN_SIZE_Y=${SCREEN_SIZE#*x}

    if [ $RECOVERY = true  ]; then
	BS=$(( $SCREEN_SIZE_X * 4 ))
	PIX_FMT="bgr0"
    else
	BS=$(( $SCREEN_SIZE_X * 2 ))
	PIX_FMT="rgb565"
    fi

    $ADB shell "cat $FB_PATH > /data/local/tmp/$TMP_FB"
    $ADB pull /data/local/tmp/$TMP_FB $TMP_FB
    dd bs=$BS count=$SCREEN_SIZE_Y if=$TMP_FB of=$TMP_FB_RS

    $FFMEG -vcodec rawvideo -f rawvideo -pix_fmt $PIX_FMT -s $SCREEN_SIZE \
	   -i $TMP_FB_RS -f image2 -vcodec png $OUTFILE

    # cleanup
    rm -f $TMP_FB $TMP_FB_RS
}

while true
do
    case "$1" in
	-r|--recovery)
	    RECOVERY=true
	    shift
	    ;;
	-f|--filename)
	    OUTFILE="$2"
	    shift 2
	    ;;
	-s|--screen-size)
	    SCREEN_SIZE="$2"
	    shift 2
	    ;;
	-h|--ssh-host)
	    SSH_HOST="$2"
	    shift 2
	    ;;

	"")
	    break
	    ;;
	*)
	    echo "Unknown option"
	    print_usage
	    exit 1
	    ;;
    esac
done

if [ -z "${SSH_HOST}" ] ; then
	ADB="$ADB_PATH"
else
	ADB="ssh_wrapper"
fi

if [ "$OUTFILE" = "" ]; then
    echo "No output file specified"
    print_usage
    exit 1
fi

if [ $RECOVERY = true ] && [ -f $SCREEN_SIZE ]; then
    print_recovery_advice
    exit 1
fi

if [ $RECOVERY = false ] && [ -f $SCREEN_SIZE ]; then
    get_screen_size
fi

take_screenshot

echo "Finished successfully"
