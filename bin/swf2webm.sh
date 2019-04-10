#!/bin/bash
# based on: https://stackoverflow.com/questions/20194270/convert-compressed-swf-to-mp4

# parameter parsing:
while getopts c:t:i:s: param ; do
    case $param in
        c)
            CRF=$OPTARG
            ;;
        t)
            DURATION=$OPTARG
            ;;
        i)
            SWFFILE=$OPTARG
            ;;
        s)
            SCALE=$OPTARG
            ;;
        *)
            echo "Error"
    esac
done
shift "$(($OPTIND -1))"

CRF=${CRF:-30} # default crf is 30
SCALE=${SCALE:-1} # defalut scaling is 1
OUTFILE=${SWFFILE%.*}.webm
TMPVID=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 32 | head -n 1).raw
TMPWAV=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 32 | head -n 1).wav
TMPMP4=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 32 | head -n 1).mp4

# create raw-dump
if [ -z "$DURATION" ]
then
    GNASHCMD="-1" # until last frame when duration is not specified
else
    GNASHCMD="-t $DURATION" # set duration when it is specified
fi

GNASHCMD="$GNASHCMD -r 3 -v -s $SCALE -D $TMPVID -A $TMPWAV $SWFFILE"
echo $GNASHCMD
OUTPUT="$(dump-gnash $GNASHCMD | tee /dev/tty)"

# extract parameters
WIDTH="$(echo $OUTPUT | grep -o 'WIDTH=[^, }]*' | sed 's/^.*=//')"
HEIGHT="$(echo $OUTPUT | grep -o 'HEIGHT=[^, }]*' | sed 's/^.*=//')"
FPS="$(echo $OUTPUT | grep -o 'FPS_ACTUAL=[^, }]*' | sed 's/^.*=//')"

set -x
# create webm
ffmpeg -i $TMPWAV \
        -f rawvideo -pix_fmt rgb32 -s:v ${WIDTH}x$HEIGHT -r $FPS -i $TMPVID \
        -c:v libvpx-vp9 -r $FPS -b:v 0 -crf $CRF -row-mt 1 \
        $OUTFILE

# clean up
rm -rf $TMPVID
rm -rf $TMPWAV
