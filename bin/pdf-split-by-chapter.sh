#!/bin/bash
# Klammer () wandelt delimitierte linie automatisch nach Array um.
PAGES=($(pdftk "$1" dump_data | grep "BookmarkLevel: 1" --before-context 2 --after-context 1\
                              | grep "BookmarkPageNumber:" \
                              |  sed 's/[^0-9]*//g')
      end )

for ((i=0; i < ${#PAGES[@]} - 1; ++i)); do
    A=${PAGES[i]}
    B=${PAGES[i+1]}
    [ "$B" = "end" ] || B=$[B-1] # last page -1 until the end
    echo $A
    echo $B
    pdftk "$1" cat $A-$B output "$1"_$A-$B.pdf
done
