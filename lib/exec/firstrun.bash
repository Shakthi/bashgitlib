#!/bin/bash
import uniqrun
set -x
uniqrun_run || exit 0

trap uniqrun_exit EXIT


if [ -f  $import_datapath/firstrun ];then
for i in $(cat $import_datapath/firstrun);
do
(
    
    launcher.bash $i &
)
done
fi

