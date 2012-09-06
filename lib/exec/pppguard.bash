#!/bin/bash

import network
import google
import uniqrun
set -x
exec 2>$BGIT_BASEDIR/lib/vardata/log/pppguard.log
uniqrun_global=yes
uniqrun_run ||exit

trap uniqrun_exit EXIT
while true;do
    if network_isppp; then
	  google_ping >/dev/null 2>&1 
    sleep 40
    else
    sleep 100
    fi


done

