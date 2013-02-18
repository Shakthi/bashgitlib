#!/bin/bash
#local modulename=import
test  -z $import_imported ||return 0

import_imported=1

function import()
{

local localimportpath=$BGIT_BASEDIR/lib/src
local errorcode=0
   for i in $*; do
     
    local iimported=$(eval echo \$$i"_imported")
    if test -z $iimported ;then
     local name=$i
     local fullname=$localimportpath/$name.snippest
     if test -e $fullname ;then
        if test -z "$import_path" ;then
            import_configPath=$BGIT_BASEDIR/config/
            import_path=$localimportpath
            import_datapath=$BGIT_BASEDIR/config/importdata
        fi

        source $fullname
        iimported=$(eval echo \$$i"_imported")
        if test -z $iimported ;then
            eval $i"_imported"="1"
        fi
        if [ x$iimported == x"0" ] ;then
            unset $i"_imported"
        fi
     else
        echo "import: $name is not found" >/dev/stderr
        errorcode=1
     fi
    
    fi 
   done
    return $errorcode
} 

export -f import


function _import_envsetup()
{

if [ -z $import_path ];then


import_configPath=$BGIT_BASEDIR/config/
import_path=$BGIT_BASEDIR/lib/src
import_datapath=$BGIT_BASEDIR/config/importdata

fi
[[  $1 == --export ]] && export import_configPath import_path import_datapath


}



function import_list()
{
(  _import_envsetup
  ls $import_path|grep snippest|sed s+.snippest$++
)
}


function _importtobe_complete()
{
    COMPREPLY=( $(
    _import_envsetup
    local  completter=();
    for i in $(ls $import_path|grep snippest|sed s+.snippest$++);
     do
        local iimported=$(eval echo \$$i"_imported")
        if test -z $iimported ;then
            completter=( "${completter[@]}" "$i" )
        fi        
     done

    local cur=${COMP_WORDS[COMP_CWORD]}
    compgen  -W "$(echo ${completter[@]} )" -- $cur
    ) )
    return 0;   
}


function _import_complete()
{
    COMPREPLY=( $(_import_envsetup
    local  completter=();
    for i in $(ls $import_path|grep snippest|sed s+.snippest$++);
    do
        completter=( "${completter[@]}" "$i" )
    done

    local cur=${COMP_WORDS[COMP_CWORD]}
    compgen  -W "$(echo ${completter[@]} )" -- $cur))
    return 0;   
}


if [ -f  $BGIT_BASEDIR/config/importdata/autoimport ];then
for i in $(cat $BGIT_BASEDIR/config/importdata/autoimport);do
 import $i 
done
fi
(
_import_envsetup --export
export launcher_datapath=$BGIT_BASEDIR/config/launcher
PATH=$BGIT_BASEDIR/bin:$BGIT_BASEDIR/lib/exec:$PATH launcherlauncher.bash 
)

complete -F _importtobe_complete  import


