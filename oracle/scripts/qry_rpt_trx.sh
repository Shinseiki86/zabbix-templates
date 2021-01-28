#!/bin/bash

path_sh=$(dirname "$0")
cd $path_sh
source $path_sh/exports.sh
export ORACLE_SID=ctc

#sqlplus -S cnb/cnbgyforabd0 @/etc/zabbix/scripts/qry_rpt_trx.sql 

printf "{" #> tablespace.json
result=`sqlplus -S cnb/cnbgyforabd0 @/etc/zabbix/scripts/qry_rpt_trx.sql`
echo "$result" | awk '{print t "\""$1"\":\""$2"\" "} {t=","}' #>> result.json
#echo "$result" | awk '{print t "{\"{#"$1"}\":\""$2"\" }"} {t=","}' #>> result.json
printf "}" #>> result.json