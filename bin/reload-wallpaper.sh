#!/bin/bash
FILE_INDEX=/tmp/$USER-wallpaper/wallpaperindex
FILE_DIR=/tmp/$USER-wallpaper/wallpaperdir

INDEX=`cat $FILE_INDEX`
WDIR=`cat $FILE_DIR`
PICS=($WDIR/*.*)
echo "[$INDEX]: ${PICS[$INDEX]}"
feh --bg-fill "${PICS[$INDEX]}"
