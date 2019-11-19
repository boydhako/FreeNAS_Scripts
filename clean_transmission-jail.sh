#! /bin/bash -xv
JID="`jls | grep transmission | awk '{printf $1}'`"

jexec $JID /root/clean_transmission.sh
