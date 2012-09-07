#!/bin/bash
read cmd <$import_datapath/launcherlauncher
if [ ! -z $cmd ];then 
cmd=$(which $cmd)
setsid $cmd >/dev/null 2>/dev/null </dev/null &
fi
