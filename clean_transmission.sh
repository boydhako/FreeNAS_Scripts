#!/bin/sh
SERVER="9091 --auth transmission:transmission"
TR="/usr/local/bin/transmission-remote"

GETIDS="`transmission-remote $SERVER --list | egrep -e "100%" | egrep -e "Finished" | awk '{printf $1" "}'`"

for ID in $GETIDS
	do
	STATE="`$TR $SERVER --torrent $ID --info | egrep -e "^  State:" | awk -F: '{printf $2}' | tr -d [:space:]`"
	DONE="`$TR $SERVER --torrent $ID --info | egrep -e "^  Percent Done:" | awk -F: '{printf("%s",$2)}' | tr -d [:space:]`"
	if [ "$STATE" == "Finished" -a "$DONE" == "100%" ]; then
		$TR $SERVER --torrent $ID -rad
	fi
	done 
date >> /root/last_cleaned.log
