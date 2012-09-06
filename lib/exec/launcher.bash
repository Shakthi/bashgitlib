#!/bin/bash
exec 2>>$BGIT_BASEDIR/lib/vardata/log/launch.log
set -x
if [ $# -ne  0 ];then

 if [ ! -p $BGIT_BASEDIR/lib/vardata/run/launchControler ];
 then
  sleep 1  
     if [ ! -p $BGIT_BASEDIR/lib/vardata/run/launchControler ];then
    nohup launcher.bash </dev/null &
    sleep 1
     fi
 fi  
  echo  "$@"  >$BGIT_BASEDIR/lib/vardata/run/launchControler
  exit 0
fi

import uniqrun
uniqrun_run ||exit 0
trap ' uniqrun_exit;rm $BGIT_BASEDIR/lib/vardata/run/launchControler;kill 0' EXIT
cd $BGIT_BASEDIR/
echo $PATH


controlfile=$BGIT_BASEDIR/lib/vardata/run/launchControler
test -p $controlfile||mkfifo $controlfile
nohup launcher.bash firstrun.bash </dev/null &


while true ;
do
 jobs
 cmd=$(cat $controlfile)
 if [[ $cmd == "exit" ]];then
  echo hai
  exit 0 
 fi 
 echo luacnhing $cmd in bg;
 $cmd </dev/null &
echo luached $cmd in bg
done


