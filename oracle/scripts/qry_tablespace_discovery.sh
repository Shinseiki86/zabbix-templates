#!/bin/bash

path_sh=$(dirname "$0")
cd $path_sh
source $path_sh/exports.sh

printf "[" #> tablespace.json
n=2
for sid in ctc baco; do
	export ORACLE_SID=$sid
	tablespace=`sqlplus -S / as sysdba @/etc/zabbix/scripts/qry_tablespace_discovery.sql`
	echo "$tablespace" | awk -v sid=$sid '{print t "{\"{#SID}\":\""sid"\", \"{#TABLESPACE}\":\""$1"\" }"} {t=","}' #>> tablespace.json
	n=$((n-1))
	if [ $n -gt 0 ]; then
		echo "," #>> tablespace.json
	fi
done
printf "]" #>> tablespace.json