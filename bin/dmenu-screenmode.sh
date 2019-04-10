#!/bin/bash
set -e
DIR="$HOME/.screenlayout"

#get all script names
SCRIPTS=""
for FILE in $DIR/* 
do
    SCRIPTS="$SCRIPTS${FILE##*/}\n"
done

CHOICE=$(echo $SCRIPTS | sed 's/.sh//g')"manual"
SELECTION=$(echo -e $CHOICE | dmenu)
if [ $SELECTION = "manual" ]
then
    arandr
else
    $DIR/$SELECTION.sh
fi
echo $SELECTION
