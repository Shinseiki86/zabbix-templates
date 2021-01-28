#!/bin/bash

path_sh=$(dirname "$0")
cd $path_sh
source $path_sh/exports.sh

export ORACLE_SID=varios

printf "[" #> disk.json
disk=`sqlplus -S / as sysdba @$path_sh/qry_asm_diskgroup_discovery.sql`
echo "$disk" | awk -v sid=$1 -v ver=$2 '{print t "{ \"{#DISKGROUP}\":\""$1"\" }"} {t=","}' #>> disk.json
printf "]" #>> disk.json