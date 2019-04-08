#!/bin/bash
rsrc="rsync://centos.mirror.liquidtelecom.com/centos"
destdir="/mnt/MAIN/Software/Operating_Systems"
tmp="/tmp/Centos-rsync.list"
date="$(date +%F-%H%M%S)"
logdir="/mnt/MAIN/HOME/binary/.logs"
log="$logdir/CentOS-rsync-$date.log"

function GETINFO {
	rsync $rsrc > $tmp
	let major="$(awk '{printf $NF"\n"}' $tmp | egrep -e "^[[:digit:]]" | awk -F. '{printf $1"\n"}' | sort -un | tail -n 1)"
	let minor="$(awk '{printf $NF"\n"}' $tmp | egrep -e "^$major" | awk -F. '{printf $2"\n"}' | sort -un | tail -n 1)"
	let update="$(awk '{printf $NF"\n"}' $tmp | egrep -e "^$major.$minor" | awk -F. '{printf $3"\n"}' | sort -un | tail -n 1)"
	if [ -z "$major" -o -z "$minor" ]; then
		exit
	else
		if [ -z "$update" ]; then
			version="$major.$minor"
		else
			version="$major.$minor.$update"
		fi
	fi
	destdir="$destdir/Centos/$version"
	if [ ! -e "$destdir" ]; then
		mkdir -p $destdir
	fi
}
function GETCENTOS {
	rsync -vrhiz --exclude="*.torrent" --log-file=$log $rsrc/$version/isos/ $destdir
}
function CLEANUP {
	rm -rf $tmp
}
function MAIN {
	GETINFO
	GETCENTOS
	CLEANUP
}
MAIN
