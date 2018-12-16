#!/bin/bash -xv
itunesdata="/mnt/MAIN/Media/Music00"
location="file:///Volumes/The%20Glove/iTunes-The_Glove"
jaillocation="file:///mnt/Music00"

function GETINFO {
	jaillocation="$(echo $jaillocation | sed 's/ /%20/g')"
	for libdb in  $(find $itunesdata -type f -name "iTunes Library.xml" | sed 's/ /%20/g'); do
		lib="$(echo $libdb | sed 's/%20/ /g')"
		dir="$(dirname "$(echo $libdb | sed 's/%20/ /g')")"
		newfile="$dir/$(basename "$lib" | sed 's/ /_/g')"
		sed "s#${location}#${jaillocation}#g" "$lib" > "$newfile"
		chmod 666 "$newfile"
	done
}
function MAIN {
	GETINFO
}
MAIN
