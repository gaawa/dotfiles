!#/bin/bash

ffmpeg -r $3 -i "$1" -lavfi palettegen=stats_mode=single[pal],[0:v][pal]paletteuse=new=1 "$2" 
