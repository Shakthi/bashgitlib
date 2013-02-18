#!/bin/bash
import network
set -x
if [ ! -z $1 ];then
  if grep -qv $1 $launcher_datapath/netrun ;then
    echo $1 >>$launcher_datapath/netrun
  fi

else


wasreachable=no
while true;do
    if network_isreachable; then
        if [[ $wasreachable == no ]];then
                if [ -f  $launcher_datapath/netrun ];then
                    for i in $(cat $launcher_datapath/netrun);
                        do
                        $i &
                    done
                fi
            
                wasreachable=yes
        fi



    sleep 40

    else
    if [[ $wasreachable == yes ]];then

     kill $(jobs -p)   
    wasreachable=no
    fi
    sleep 100
  fi
done
fi
