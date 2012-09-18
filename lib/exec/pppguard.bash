#!/bin/bash

import network
import google
import uniqrun
set -x
exec 2>&1
uniqrun_global=yes
uniqrun_run ||exit

trap uniqrun_exit EXIT
while true;do
    if network_isppp; then
       echo "#Date:$(date)">>$BGIT_BASEDIR/lib/vardata/log/pppguard.log      
	  google_ping >>$BGIT_BASEDIR/lib/vardata/log/pppguard.log
    sleep 40
    else
    sleep 100
    fi


done

