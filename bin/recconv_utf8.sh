#!/bin/bash

FILES=`find . -name '*.tex' -or -name '*.bib'`
for i in $FILES
do
  CHARSET=$(file -bi $i | cut -d "=" -f 2)
  echo $CHARSET
  iconv -f $CHARSET -t UTF-8 "$i" -o "$i"
done
