#! /bin/bash
MAILTO="root"
NOW="`date -jn +%Y-%m-%d_T%H-%M-%S`"
DB="/data/freenas-v1.db"
DIR="/mnt/MAIN/backups/Freenas"
DESTDIR="$DIR/config_backup"
BCKDB="$DESTDIR/freenas-v1-$NOW.db"
MD5FILE="$DESTDIR/freenas.md5"
COMPRESS="1"
ENABLEMAIL="1"
LOGDIR="$DIR/logs"
LOG="$LOGDIR/freenas-config-backup-$NOW.log"
TMP="/var/tmp/configbackup.tmp"

CURRENT="`md5 $DB | awk '{printf $NF}'`"

function checkfiles {
	if [ ! -d "$LOGDIR" ]; then
		mkdir -pv $LOGDIR
	fi
	if [ ! -d "$DESTDIR" ]; then
		printf "Making backup directory at $DESTDIR...\n" >> $LOG
		mkdir -pv $DESTDIR
	fi
	if [ ! -e "$DB" ]; then
		printf "%s doesn't exist... You\'re kinda screwed... lol\n" $DB >> $LOG
		exit 1
	fi
	INSTALLED="`ls -l $DESTDIR | wc -l | tr -d [:space:]`"
	if [ "$INSTALLED" -le "1" ]; then
		printf "Not seeing any current files. Creating the first set now.\n" >> $LOG
		initmd5
	fi
	if [ ! -e "$MD5FILE" ]; then
		touch $MD5FILE
	fi
}

function backup {
	printf "Copying %s to %s...\n" $DB $BCKDB >> $LOG
	cp -v $DB $BCKDB
	printf "Recording %s to %s...\n" $BCKDB $MD5FILE >> $LOG
	md5 -r $BCKDB >> $MD5FILE
	if [ "$COMPRESS" == "1" ]; then
		makesmall
	fi
	printf "Recording %s to %s.\n" $BCKDB $MD5FILE >> $LOG
	md5 -r $BCKDB >> $MD5FILE
}

function makesmall {
	printf "Compressing %s to %s...\n" "$BCKDB" "$BCKDB.lzma" >> $LOG
	xz --format=lzma --suffix=.lzma -v -v -k $BCKDB >> $LOG 2>&1
	printf "Deleting $BCKDB.\n" >> $LOG
	rm -f $BCKDB
	BCKDB="$BCKDB.lzma"	
	printf "$BCKDB is the new backup file compressed with LZMA.\n" >> $LOG
}

function mailreport {
	HOST="`hostname`"
	SUBJECT="$HOST: New Freenas Config was backed up"
	mailx -s "$SUBJECT" "$MAILTO" < $LOG
}

function main {
	checkfiles
	EXISTS="`grep $CURRENT $MD5FILE | wc -l | tr -d [:space:]`"
	if [ "$EXISTS" == "0" ]; then
		backup
		if [ "$ENABLEMAIL" == "1" ]; then
			mailreport
		fi
	fi
}

main 
