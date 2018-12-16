#!/bin/bash
###########################
#	itunesdata is the FreeNAS location view of where the iTunes Library is.
#	location is the stated location in the "iTunes Library.xml" file.
#	jaillocation is the Jail Plugin view of where the iTunes Library is.
###########################

itunesdata="/mnt/MAIN/Media/Music00"
location="file:///Volumes/The%20Glove/iTunes-The_Glove"
jaillocation="file:///mnt/Music00"

function MAIN {
	jaillocation="$(echo $jaillocation | sed 's/ /%20/g')"
	for libdb in  $(find $itunesdata -type f -name "iTunes Library.xml" | sed 's/ /%20/g'); do
		lib="$(echo $libdb | sed 's/%20/ /g')"
		dir="$(dirname "$(echo $libdb | sed 's/%20/ /g')")"
		newfile="$dir/$(basename "$lib" | sed 's/ /_/g')"
		sed "s#${location}#${jaillocation}#g" "$lib" > "$newfile"
		chmod 666 "$newfile"
	done
}
MAIN
