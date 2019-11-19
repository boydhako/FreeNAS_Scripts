#! /bin/bash
LOG="$HOME/modem_out.log"
PAGE="http://192.168.100.1/indexData.htm"
STATUS="`curl $PAGE | grep \<TD\> | sed 's/<TD>//g' | sed 's/<\/TD>//g' | sed 's/<\/TR>//g' | sed 's/[[:space:]][[:space:]][[:space:]][[:space:]]//g'`"
DONES="`curl $PAGE | grep Done | wc -l | sed 's/ //g'`"

if [ "$DONES" != "7" ]; then
	TIME="`date`"
	touch $LOG
	printf "=== Modem Down @ %s ===\n%s\n" "$TIME" "$STATUS" >> $LOG	
	curl http://192.168.100.1/cmSignalData.htm | tail -n 62 | head -n 55 >> $LOG
fi
