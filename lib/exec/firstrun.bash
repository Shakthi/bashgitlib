#!/bin/bash
import uniqrun
set -x
uniqrun_run || exit 0

trap uniqrun_exit EXIT


if [ -f  $import_datapath/firstrun ];then
for i in $(cat $import_datapath/firstrun);
do
(
    PATH=$BGIT_BASEDIR/bin:$BGIT_BASEDIR/lib/exec:$PATH;
    launcher.bash $i &
)
done
fi

sleep 10000000


