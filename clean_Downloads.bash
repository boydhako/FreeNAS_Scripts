#!/bin/bash
DOWNDIR="/mnt/MAIN/Media/COMPLETED_DOWNLOADS/"
for END in *.ignore *.nfo *.png *.txt *.exe *.plist *.wflow *.workflow *._Contents *.sfv *.srr *.docx *.xlsx *.nzb *.idx *.pdf *.html *.website ; do
	find $DOWNDIR -type f -iname "$END" -delete
done

find $DOWNDIR -type d -empty -delete
