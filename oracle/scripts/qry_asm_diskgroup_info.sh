#!/bin/bash

path_sh=$(dirname "$0")
source $path_sh/exports.sh
export ORACLE_SID=varios

#sqlplus -S / as sysdba @$path_sh/qry_asm_diskgroup_info.sql
printf "[" #> disk.json
disk=`sqlplus -S / as sysdba @$path_sh/qry_asm_diskgroup_discovery.sql`
echo "$disk" | awk -v sid=$1 -v ver=$2 '{print t "{ \""$1"\": { \"TOTAL_MB\":"$2",\"FREE_MB\":"$3" } }"} {t=","}' #>> disk.json
printf "]" #>> disk.json