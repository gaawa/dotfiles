#!/bin/bash
CHOICES="video\naudio\n"

SELECTION=$(echo -e $CHOICES | dmenu)
# run youtube-dl and send notification
if [ $SELECTION = "video" ]
then
    STDE=$(youtube-dl -o '~/Videos/%(title)s-%(id)s.%(ext)s' \
        "$(xclip -out -selection clipboard)" \
        2>&1 >/dev/null) 
    if [ $? -eq 1 ]
    then
        notify-send -u critical YOUTUBE-DL "error in youtube-dl:\n$STDE"
    else
        notify-send YOUTUBE-DL "video successfully downloaded in ~/Videos"
    fi
elif [ $SELECTION = "audio" ]
then
    STDE=$(youtube-dl -f bestaudio -o '~/Music/%(title)s-%(title)s.%(ext)s' \
        "$(xclip -out -selection clipboard)" \
        2>&1 >/dev/null)
    if [ $? -eq 1 ]
    then
        notify-send -u critical YOUTUBE-DL "error in youtube-dl:\n$STDE"
    else
        notify-send YOUTUBE-DL "audio successfully downloaded in ~/Music"
    fi
fi
