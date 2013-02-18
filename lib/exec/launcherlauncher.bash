#!/bin/bash
read cmd <$launcher_datapath/launcherlauncher
if [ ! -z $cmd ];then 
cmd=$(which $cmd)
setsid $cmd >/dev/null 2>/dev/null </dev/null &
fi
