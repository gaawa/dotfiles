#!/bin/bash
# check if number of passed parameter is 1
if [ $# -ne 1 ]
then
  echo "$0 takes one parameter. Valid options:
    forward
    backward"
  exit
fi

#switch case
case "$1" in
  forward) cycle-wallpaper-forward.sh
    ;;

  backward) cycle-wallpaper-backward.sh
    ;;

  *) echo "Invalid parameter. Valid options:
    forward
    backward"
    ;;

esac
