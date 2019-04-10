#!/bin/sh

palette="/tmp/palette.png"

filters="fps=25,scale=320:-1:flags=lanczos"

ffmpeg -v warning -i "$1" -vf "$filters,palettegen" -y $palette
ffmpeg -r 50 -v warning -i "$1" -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y "$2"
