#!/bin/bash

## Notes
##	/mnt/MAIN/Media/Music00
##	drwxr-xr-x  7 binary  keoni          7 Oct 19 01:23 Album Artwork
##	drwxr-xr-x  2 binary  keoni          9 Sep 16 01:11 Previous iTunes Libraries
##	drwxr-xr-x  7 binary  keoni         14 Sep 29 01:16 WPI
##	-rw-r--r--  1 binary  keoni    2277376 Mar  8 01:12 iTunes Library Extras.itdb
##	-rw-r--r--  1 binary  keoni  455507968 Mar  8 01:13 iTunes Library Genius.itdb
##	-rw-r--r--  1 binary  keoni   12781722 Mar  9 01:19 iTunes Library.itl
##	-rw-r--r--  1 binary  keoni   52502251 Mar  9 01:19 iTunes Library.xml
##	drwxr-xr-x  9 binary  keoni         10 Aug 10  2016 iTunes Media
##	-rw-r--r--  1 binary  keoni          8 Feb 25 01:11 sentinel

DIR="/mnt/MAIN/Media/Music00"
XML="$DIR/iTunes_Library.xml"
XML0="$DIR/iTunes_Library-0.xml"

cp $DIR/*Library.xml $XML

sed 's/\/Volumes\/The%20Glove\/iTunes-The_Glove/\/media\/Music00/g' $XML > $XML0






