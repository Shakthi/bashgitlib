#!/bin/bash

if [ -r $launcher_datapath/launcherlauncher ];then
    read cmd <$launcher_datapath/launcherlauncher
    if [ ! -z $cmd ];then 
    cmd=$(which $cmd)
    setsid $cmd >/dev/null 2>/dev/null </dev/null &
    fi
fi