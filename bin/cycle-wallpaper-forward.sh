#!/bin/bash
###############################################################
#
# Reads current wallpaper index from /tmp/wallpaperindex.
# Then counts up that index and uses it to change to the next
# wallpaper.
# Overwrites /tmp/wallpaperindex with the new index.
#
###############################################################
FILE_INDEX=/tmp/$USER-wallpaper/wallpaperindex
FILE_DIR=/tmp/$USER-wallpaper/wallpaperdir
if [ ! -f $FILE_INDEX ] || [ ! -f $FILE_DIR ]; then
  echo "something wrong"
  make-wallpaper.sh
fi
INDEX=`cat $FILE_INDEX`
WDIR=`cat $FILE_DIR`
PICS=($WDIR/*.*)
N_PICS=${#PICS[@]}
if [ "$INDEX" -ge `expr $N_PICS - 1` ]
then
  INDEX=0
else
  INDEX=`expr $INDEX + 1`
fi
#echo $INDEX
echo $INDEX > $FILE_INDEX
echo "[$INDEX]: ${PICS[$INDEX]}"
feh --bg-fill "${PICS[$INDEX]}"
