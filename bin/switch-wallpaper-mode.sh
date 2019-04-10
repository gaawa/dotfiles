#!/bin/bash
DIR_SFW=/tmp/$USER-wallpaper/wallpaperdir_sfw
DIR_NSFW=/tmp/$USER-wallpaper/wallpaperdir_nsfw
DIR_WEEB=/tmp/$USER-wallpaper/wallpaperdir_weeb
DIR=/tmp/$USER-wallpaper/wallpaperdir

I_SFW=/tmp/$USER-wallpaper/wallpaperindex_sfw
I_NSFW=/tmp/$USER-wallpaper/wallpaperindex_nsfw
I_WEEB=/tmp/$USER-wallpaper/wallpaperindex_weeb
I=/tmp/$USER-wallpaper/wallpaperindex

# check if number of passed parameter is 1
if [ $# -ne 1 ]
then
  echo "$0 takes one parameter. Valid options:
    sfw
    weeb
    nsfw"
  exit
fi

# swich case
case "$1" in
  #switch to sfw wallpaper
  sfw)  cat $DIR_SFW > $DIR
        cat $I_SFW > $I
        ;;

  #switch to nsfw wallpaper
  nsfw) cat $DIR_NSFW > $DIR
        cat $I_NSFW > $I
        ;;

  #switch to weeb wallpaper
  weeb) cat $DIR_WEEB > $DIR
        cat $I_WEEB > $I
        ;;

  *)    echo "Invalid parameter. Valid options:
    sfw
    weeb
    nsfw"
        ;;
esac

reload-wallpaper.sh
