#!/bin/bash
#local modulename=import
#set -x
test  -z $import_imported ||return 0


import_imported=1
export import_path=$BGIT_BASEDIR/lib/bin
export import_datapath=$BGIT_BASEDIR/config/importdata

function import()
{
 #set -x
   for i in $*; do
     
    local iimported=$(eval echo \$$i"_imported")
    if test -z $iimported ;then
     local name=$i
     local fullname=$import_path/$name.snippest
     if test -e $fullname ;then
      source $fullname
      iimported=$(eval echo \$$i"_imported")
      if test -z $iimported ;then
       eval $i"_imported"="1"
      fi
      if [ x$iimported == x"0" ] ;then
       unset $i"_imported"
      fi
     fi
    fi 
   done
} 

export -f import
function unimport()
{


#set -x
   for i in $*; do
     local iimported=$(eval echo \$$i"_imported")
     if test ! -z $iimported ;then
      "$i"_unimport ;
      unset $i"_imported"
     fi
   done


} 

function import_list()
{
  ls $import_path|grep snippest|sed s+.snippest$++
}


function importtobe_list()
{
    for i in $(ls $import_path|grep snippest|sed s+.snippest$++);
     do
        local iimported=$(eval echo \$$i"_imported")
        if test -z $iimported ;then
            echo $i 
        fi        
     done
    
}



function  import_unimport()
{

 unset unimport 
 unset import_unimport 
 unset import_imported
 unset import_edit
 unset import

}



if [ -f  $import_datapath/autoimport ];then
for i in $(cat $import_datapath/autoimport);do
 import $i 
done
fi

complete -W "$(importtobe_list)"  import


