#!/bin/bash
CHOICES="video\naudio\nmpv"

SELECTION=$(echo -e $CHOICES | dmenu)
case $SELECTION in
    "video")
        notify-send YOUTUBE-DL "Downloading $SELECTION started"
        STDE=$(youtube-dl -o '~/Videos/%(title)s-%(id)s.%(ext)s' \
                "$(xclip -out -selection clipboard)" \
                2>&1 >/dev/null) 
        [ $? -eq 1 ] \
            && notify-send -u critical YOUTUBE-DL "error in youtube-dl:\n$STDE" \
            || notify-send YOUTUBE-DL "video successfully downloaded in ~/Videos"
        ;;
    "audio")
        notify-send YOUTUBE-DL "Downloading $SELECTION started"
        STDE=$(youtube-dl -f bestaudio -o '~/Music/%(title)s-%(title)s.%(ext)s' \
            "$(xclip -out -selection clipboard)" \
            2>&1 >/dev/null)
        [ $? -eq 1 ] \
            && notify-send -u critical YOUTUBE-DL "error in youtube-dl:\n$STDE" \
            || notify-send YOUTUBE-DL "audio successfully downloaded in ~/Music"
        ;;
    "mpv")
        notify-send MPV "playing from clipboard with $SELECTION"
        STDE=$(mpv "$(xclip -out -selection clipboard)" 2>&1 >/dev/null)
        [ $? -eq 1 ] && notify-send -u critical MPV "error while playing:\n$STDE"
        ;;
    *)
        notify-send -u critical YOUTUBE-DL "unknown setting"
        ;;
esac
