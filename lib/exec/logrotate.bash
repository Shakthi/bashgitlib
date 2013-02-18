#!/bin/bash
import logrotate;

for i in $BGIT_BASEDIR/lib/vardata/log/*.log
do
 logrotate_rotate $i

done
