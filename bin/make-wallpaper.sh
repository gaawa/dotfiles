#!/bin/bash
###############################################################
#
# Chooses random Picture from wallpaper directory and sets it
# as wallpaper.
# Saves file index to /tmp/wallpaperindex
#
###############################################################
WDIR_SFW="$HOME/Pictures/Wallpapers/sfw"
WDIR_NSFW="$HOME/Pictures/Wallpapers/nsfw"
WDIR_WEEB="$HOME/Pictures/Wallpapers/weeb"

mkdir /tmp/$USER-wallpaper
echo $WDIR_SFW > /tmp/$USER-wallpaper/wallpaperdir_sfw
echo $WDIR_NSFW > /tmp/$USER-wallpaper/wallpaperdir_nsfw
echo $WDIR_WEEB > /tmp/$USER-wallpaper/wallpaperdir_weeb
# default wallpaper mode is sfw
echo $WDIR_SFW > /tmp/$USER-wallpaper/wallpaperdir

PICS_SFW=($WDIR_SFW/*.*)
N_PICS_SFW=${#PICS_SFW[@]}
INDEX_SFW=`shuf --input-range=0-$(expr $N_PICS_SFW - 1) --head-count=1`

PICS_NSFW=($WDIR_NSFW/*.*)
N_PICS_NSFW=${#PICS_NSFW[@]}
INDEX_NSFW=`shuf --input-range=0-$(expr $N_PICS_NSFW - 1) --head-count=1`

PICS_WEEB=($WDIR_WEEB/*.*)
N_PICS_WEEB=${#PICS_WEEB[@]}
INDEX_WEEB=`shuf --input-range=0-$(expr $N_PICS_WEEB - 1) --head-count=1`

echo $INDEX_SFW > /tmp/$USER-wallpaper/wallpaperindex_sfw
echo $INDEX_NSFW > /tmp/$USER-wallpaper/wallpaperindex_nsfw
echo $INDEX_WEEB > /tmp/$USER-wallpaper/wallpaperindex_weeb

echo $INDEX_SFW > /tmp/$USER-wallpaper/wallpaperindex

echo "[$INDEX_SFW]: ${PICS_SFW[$INDEX_SFW]}"
feh --bg-fill "${PICS_SFW[$INDEX_SFW]}"
