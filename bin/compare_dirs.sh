#!/bin/bash
#input 2 dirs
DIR1=$1
DIR2=$2
echo "compare $DIR1 and $DIR2"
find "$DIR1" -type f -exec md5sum {} + | sort > dir1.txt && #find files in dir1 and generate md5. output as dir1.txt
find "$DIR2" -type f -exec md5sum {} + | sort > dir2.txt && #find files in dir2 and generate md5. output as dir2.txt
join -v 1 -v 2 dir1.txt dir2.txt > result.txt &&     #match md5s and print lines that doesn't have any matching md5.
rm dir1.txt dir2.txt &&
sed -i 's/^................................//' result.txt && #remove md5
sort result.txt
rm result.txt

#to replace strings: sed -i 's|/paste/some/string/here|replacement/string|g' inputfile.txt

