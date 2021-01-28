#!/bin/bash

path_sh=$(dirname "$0")
cd $path_sh
source $path_sh/exports.sh
export ORACLE_SID=varios
if [ "$1"="" ]; then
	echo "exist";
fi

result=`sqlplus -S / as sysdba @qry_unlock_userportal.sql $1`
echo "$result" 
