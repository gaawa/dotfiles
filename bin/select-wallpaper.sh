#!/bin/bash
# select mode and then select wallpaper
set -ex
get_index () {
    local SEL=$1 && shift
    local -a FILES=("$@")
    for i in "${!FILES[@]}"; do
        if [[ "${FILES[$i]}" = "$SEL" ]]; then
            echo "$i";
        fi
    done
}

get_imgsel () {
    echo "$(sxiv -to $1)"
   
}

DIR_SFW=/tmp/$USER-wallpaper/wallpaperdir_sfw
DIR_NSFW=/tmp/$USER-wallpaper/wallpaperdir_nsfw
DIR_WEEB=/tmp/$USER-wallpaper/wallpaperdir_weeb
DIR=/tmp/$USER-wallpaper/wallpaperdir

I_SFW=/tmp/$USER-wallpaper/wallpaperindex_sfw
I_NSFW=/tmp/$USER-wallpaper/wallpaperindex_nsfw
I_WEEB=/tmp/$USER-wallpaper/wallpaperindex_weeb
INDEX=/tmp/$USER-wallpaper/wallpaperindex

# ask for mode
case $(echo -e "SFW\nWEEB\nNSFW" | dmenu -i -p "Which wallpaper mode?") in
    "SFW")
        #SEL=$(sxiv -to $(cat $DIR_SFW))
        SEL="$(get_imgsel $(cat $DIR_SFW))"
        [ -z "$SEL" ] && exit 1
        PICS=($(cat $DIR_SFW)/*.*)
        I=$(get_index "$SEL" "${PICS[@]}") 
        [ -z $I ] && exit 1
        cat $DIR_SFW > $DIR
        echo $I > $I_SFW
        ;;
    "WEEB")
        SEL="$(get_imgsel $(cat $DIR_WEEB))"
        [ -z "$SEL" ] && exit 1
        PICS=($(cat $DIR_WEEB)/*.*)
        I=$(get_index "$SEL" "${PICS[@]}")
        [ -z $I ] && exit 1
        cat $DIR_WEEB > $DIR
        echo $I > $I_WEEB
        ;;
    "NSFW")
        SEL="$(get_imgsel $(cat $DIR_NSFW))"
        [ -z "$SEL" ] && exit 1
        PICS=($(cat $DIR_NSFW)/*.*)
        I=$(get_index "$SEL" "${PICS[@]}")
        [ -z $I ] && exit 1
        cat $DIR_WEEB > $DIR
        echo $I > $I_NSFW
        ;;
    *)
        exit 1
        ;;
esac

echo $I > $INDEX
feh --bg-fill "${PICS[$I]}"
