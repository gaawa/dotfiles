#!/bin/bash

FILE_INDEX=/tmp/$USER-wallpaper/wallpaperindex
FILE_DIR=/tmp/$USER-wallpaper/wallpaperdir
if [ ! -f $FILE_INDEX ] || [ ! -f $FILE_DIR ]; then
  echo "something wrong. Executing make-wallpaper.sh"
  make-wallpaper.sh
fi
INDEX=`cat $FILE_INDEX`
WDIR=`cat $FILE_DIR`
PICS=($WDIR/*.*)
N_PICS=${#PICS[@]}
if [ "$INDEX" -le 0 ]
then
  INDEX=`expr $N_PICS - 1`
else
  INDEX=`expr $INDEX - 1`
fi

echo $INDEX > $FILE_INDEX
echo "[$INDEX]: ${PICS[$INDEX]}"
feh --bg-fill "${PICS[$INDEX]}"
